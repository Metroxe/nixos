{pkgs, homeDir, cursorAppImage} :
pkgs.writeShellScriptBin "cursor" ''
    # Create the Applications directory if it doesn't exist
    applications_dir="${homeDir}/Applications"
    if [[ ! -d "$applications_dir" ]]; then
        mkdir -p "$applications_dir"
    fi

    # Copy the fetched AppImage to ~/Applications
    cp ${cursorAppImage} "$applications_dir/cursor.AppImage"

    # Find the latest cursor AppImage in ~/Applications
    echo "Home Directory: ${homeDir}"
    cursor_app="$(find $applications_dir -maxdepth 1 -name 'cursor*.AppImage' | sort | tail -n 1)"
    if [[ -f "$cursor_app" ]]; then
        # Execute the AppImage if found
        appimage-run "$cursor_app" "$@"
    else
        echo "Cursor AppImage not found or not executable in ~/Applications."
        exit 1
    fi
''