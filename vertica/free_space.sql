 SELECT node_name, storage_path, disk_space_free_mb/1024 as free_GB,disk_space_free_percent FROM disk_storage where storage_status='Active';
