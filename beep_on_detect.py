import os
import time
import argparse 

def beep():
    try:
        print("\a") # BEEP
    except Exception as e:
        print(f"Beep failed: {e}")

def clean_folder(path):
    for filename in os.listdir(path):
        file_path = os.path.join(path, filename)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)  # Remove the file
            elif os.path.isdir(file_path):
                import shutil
                shutil.rmtree(file_path)  # Remove the directory
        except Exception as e:
            print(f"Error cleaning {file_path}: {e}")

def monitor_folder(path):
    if not os.path.exists(path):
        print(f"Error: The folder '{path}' does not exist.")
        return

    # Clean the dir before starting
    print(f"Cleaning old detections: {path}")
    clean_folder(path)
    print(f"Monitoring: {path}")
    print("Press Ctrl+C to stop the script.")

    # Get the initial count of labels
    previous_file_count = len(os.listdir(path))

    try:
        while True:
            current_file_count = len(os.listdir(path))
            if current_file_count > previous_file_count:
                print(f"New detections: {current_file_count}")
                beep()

            # Update file count
            previous_file_count = current_file_count
            time.sleep(1) # Pause to avoid excessive CPU usage

    except KeyboardInterrupt:
        print("\nMonitoring stopped.")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--dir')
    args = parser.parse_args()

    dir = args.dir

    #Start
    monitor_folder(dir)

if __name__ == '__main__':
    main()
