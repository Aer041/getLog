//
// Simple example to demonstrate how takeoff and land using MAVSDK. Then download logs flight at the end.
//

#include <chrono>
#include <cstdint>
#include <mavsdk/mavsdk.h>
#include <mavsdk/plugins/action/action.h>
#include <mavsdk/plugins/telemetry/telemetry.h>
#include <mavsdk/plugins/log_files/log_files.h>
#include <iostream>
#include <future>
#include <memory>
#include <thread>
#include <fstream>
#include <sstream>
#include <dirent.h>

using namespace mavsdk;
using std::chrono::seconds;
using std::this_thread::sleep_for;

//void log_download_with_selection(std::shared_ptr<LogFiles> log_files);
void log_download_auto(std::shared_ptr<LogFiles> log_files);
//std::vector<LogFiles::Entry> log_to_download_selection(std::vector<LogFiles::Entry> entry_list);
void log_download_entry_list(std::vector<LogFiles::Entry> entry_list_to_download, std::shared_ptr<LogFiles> log_files);
std::streampos get_size_of_file_at_path(std::string filePath);

void usage(const std::string& bin_name)
{
    std::cerr << "Usage : " << bin_name << " <connection_url>\n"
              << "Connection URL format should be :\n"
              << " For TCP : tcp://[server_host][:server_port]\n"
              << " For UDP : udp://[bind_host][:bind_port]\n"
              << " For Serial : serial:///path/to/serial/dev[:baudrate]\n"
              << "For example, to connect to the simulator use URL: udp://:14540\n";
}

std::shared_ptr<System> get_system(Mavsdk& mavsdk)
{
    std::cout << "Waiting to discover system...\n";
    auto prom = std::promise<std::shared_ptr<System>>{};
    auto fut = prom.get_future();

    // We wait for new systems to be discovered, once we find one that has an
    // autopilot, we decide to use it.
    mavsdk.subscribe_on_new_system([&mavsdk, &prom]() {
        auto system = mavsdk.systems().back();

        if (system->has_autopilot()) {
            std::cout << "Discovered autopilot\n";

            // Unsubscribe again as we only want to find one system.
            mavsdk.subscribe_on_new_system(nullptr);
            prom.set_value(system);
        }
    });

    // We usually receive heartbeats at 1Hz, therefore we should find a
    // system after around 3 seconds max, surely.
    if (fut.wait_for(seconds(3)) == std::future_status::timeout) {
        std::cerr << "No autopilot found.\n";
        return {};
    }

    // Get discovered system now.
    return fut.get();
}

// return a list of files with the specified extension
std::vector<std::string> file_name_list_in_directory( const std::string& path_to_dir)
{
    std::vector<std::string> list_filenames_in_directory;
    DIR *dp;
    int count = 0;
    struct dirent *ep;
    dp = opendir (path_to_dir.c_str());

    if (dp != NULL){
      while ((ep = readdir (dp))){
          std::string relative_filename = ep->d_name;

          if(relative_filename != "." && relative_filename != ".."){
              count++;
              relative_filename = "/home/pi/drone/logs/px4/" + relative_filename;
              list_filenames_in_directory.push_back(relative_filename);
              //std::cout << "The relative filename is : " << relative_filename << "\n";
          }

      }
      (void) closedir (dp);

    }else{
        std::cout << "Couldn't open the directory " << path_to_dir;
    }

    return list_filenames_in_directory;
}

// Format : log_13_2021-10-13-15-47-46.ulg
// entry.date format : 2021-09-23T16:47:36Z
// str.substr (pos,len), pos : Position of the first character to be copied as a substring. len : Number of characters to include in the substring
std::string convert_entry_to_filepath_format(std::string id, std::string date){
    std::string file_stream_in_format = "/home/pi/drone/logs/px4/log_" + id + "_" + date.substr(0,10) + "-" + date.substr(11,2) + "-" + date.substr(14,2) + "-" + date.substr(17,2) + ".ulg";

    return file_stream_in_format;
}

int main(int argc, char** argv)
{

    bool _armed = false;

    if (argc != 2) {
        usage(argv[0]);
        return 1;
    }

    Mavsdk mavsdk;
    ConnectionResult connection_result = mavsdk.add_any_connection(argv[1]);
    // Commande terminal : "./download_logs_takeoff_and_land udp://:14540", we setup a connection
    // in server mode and listen on the "SDK port 14540"

    if (connection_result != ConnectionResult::Success) {
        std::cerr << "Connection failed: " << connection_result << '\n';
        return 1;
    }

    auto system = get_system(mavsdk);
    if (!system) {
        return 1;
    }

    // Instantiate pluginis.
    auto log_files = std::make_shared<LogFiles>(system);

    /*
    auto telemetry = Telemetry{system};
    auto action = Action{system};
    
    telemetry.subscribe_armed([&](bool armed){
        _armed = armed;
    });
    */

    log_download_auto(log_files);

    std::cout << "Finished...\n";

    return 0;
}

void log_download_auto(std::shared_ptr<LogFiles> log_files){

    std::pair<LogFiles::Result, std::vector<LogFiles::Entry>> entry_result = log_files->get_entries();
    int temp = 1;

    if (entry_result.first == LogFiles::Result::Success) {
        
        std::vector<LogFiles::Entry> entry_list_to_download;
        std::vector<LogFiles::Entry> entry_list = entry_result.second;
        //std::cout << "Got the entries ! " << entry_list.size() << " logs are available for download.\n";
        //entry_list_to_download = {entry_list.begin(), entry_list.end() - temp};
        entry_list_to_download = entry_list;
        log_download_entry_list(entry_list_to_download, log_files);
    }
}

void log_download_entry_list(std::vector<LogFiles::Entry> entry_list_to_download, std::shared_ptr<LogFiles> log_files){

    bool is_in_the_list = false;
    bool incomplete_entry_downloaded = false;
    std::string path = "/home/pi/drone/logs/px4/";
    uint32_t existing_log_size_bytes;

    std::vector<std::string> list_existing_logs = file_name_list_in_directory(path);

    for (auto& entry : entry_list_to_download) {

        //== check if entry is in folder.==
            std::stringstream file_path_stream;
            file_path_stream << convert_entry_to_filepath_format(std::to_string(entry.id), entry.date);
            is_in_the_list = false;


            // check if this entry doesn't already exist in folder
            for (auto& existing_logs : list_existing_logs) {

                //std::cout << "Entry to download " << existing_logs << "\n";
                //std::cout << "Compared to " << file_path_stream.str() << " in folder \n";

                if(!existing_logs.compare(file_path_stream.str())){
                    is_in_the_list = true;
                    //std::cout << file_path_stream.str() << " already exist in folder" << "\n";

                    // check if entry found in folder is complete
                    
                    if(is_in_the_list){
                        existing_log_size_bytes = get_size_of_file_at_path(file_path_stream.str());
                        
                        //std::cout << "entry.size_bytes = " << entry.size_bytes << "\n";
                        //std::cout << "existing_log_size_bytes = " << existing_log_size_bytes << "\n";

                        if(entry.size_bytes != existing_log_size_bytes){
                            incomplete_entry_downloaded = true;
                            std::cout << "An incomplet log download has benn found. Restarting the download of this log.";
                        }else{
                            //std::cout << "Log is complete \n";
                            incomplete_entry_downloaded = false;
                        }
                    }
                    
                }
            }
        //===

        auto prom = std::promise<void>();
        auto fut = prom.get_future();

        if(!is_in_the_list || incomplete_entry_downloaded){
            log_files->download_log_file_async(
                entry,
                file_path_stream.str(),
                [&prom](LogFiles::Result result, LogFiles::ProgressData progress_data) {
                    if (result == LogFiles::Result::Next) {
                        std::cout << "Download progress: " << 100.0f * progress_data.progress << "\n";
                    } else {
                        //EXPECT_EQ(result, LogFiles::Result::Success);
                        if (result == LogFiles::Result::Success) {
                        prom.set_value();
                        }
                    }
                });

                fut.wait();
        }
    }

    return;
}

std::streampos get_size_of_file_at_path(std::string filePath){

    std::streampos fsize = 0;
    std::ifstream file( filePath, std::ios::binary );

    fsize = file.tellg();
    file.seekg( 0, std::ios::end );
    fsize = file.tellg() - fsize;
    file.close();

    return fsize;
}
