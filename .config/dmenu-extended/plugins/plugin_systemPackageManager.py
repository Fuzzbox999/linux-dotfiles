# -*- coding: utf8 -*-
import dmenu_extended
import os


class extension(dmenu_extended.dmenu):

    title = 'System package management'
    is_submenu = True
    detected_packageManager = False

    def __init__(self):
        self.load_preferences()
        self.cache_packages = dmenu_extended.path_cache + '/packages.txt'

        # Determine package manager
        if os.path.exists('/usr/bin/apt-get'):
            # We are Debian based
            self.command_installPackage = 'sudo apt-get install '
            self.command_removePackage = 'sudo apt-get remove '
            self.command_listInstalled = ['dpkg', '-l']
            self.command_listAvailable = ['apt-cache', 'search', '']
            self.command_systemUpdate = 'sudo apt-get update && sudo apt-get upgrade'
            self.detected_packageManager = 'apt-get'
        elif os.path.exists('/usr/bin/yum'):
            # We are Red Hat based
            self.command_installPackage = 'sudo yum install '
            self.command_removePackage = 'sudo yum remove '
            self.command_listInstalled = 'yum list installed'
            self.command_listAvailable = ["yum", "search", ""]
            self.command_systemUpdate = 'sudo yum update'
            self.detected_packageManager = 'yum'
        elif os.path.exists('/usr/bin/dnf'):
            self.command_installPackage = 'sudo dnf install '
            self.command_removePackage = 'sudo dnf remove '
            self.command_listInstalled = 'dnf list installed'
            self.command_listAvailable = ["dnf", "search", ""]
            self.command_systemUpdate = 'sudo dnf update'
            self.detected_packageManager = 'dnf'
        elif os.path.exists('/usr/bin/pacman'):
            # We are Arch based
            self.command_installPackage = 'sudo pacman -S '
            self.command_removePackage = 'sudo pacman -R '
            self.command_listInstalled = 'pacman -Q'
            self.command_listAvailable = 'pacman -Ss'
            self.command_systemUpdate = 'sudo pacman -Syu'
            self.detected_packageManager = 'pacman'
        elif os.path.exists('/usr/bin/emerge'):
            # We are Gentoo based
            self.command_installPackage = 'sudo emerge '
            self.command_removePackage = 'sudo emerge --unmerge '
            self.command_listInstalled = 'cd /var/db/pkg/ && ls -d */* | sed \'s/\-[0-9].*$//\' > ' + dmenu_extended.path_cache + '/tmp.txt'
            self.command_listAvailable = 'emerge --search "" | grep "*  " | cut -c 4- | sed "s/\[ Masked \]//g" | sed -n \'/^app-accessibility/,$p\' > ' + dmenu_extended.path_cache + '/tmp.txt'
            self.command_systemUpdate = 'sudo emerge --sync && sudo emerge -uDv @world'
            self.detected_packageManager = 'portage'

    def install_package(self):
        packages = self.cache_open(self.cache_packages)

        if packages == False:
            self.menu('No package database exists. Press enter to build cache')
            self.build_package_cache()
            packages = self.cache_open(self.cache_packages)

        package = self.menu(packages, prompt="Install:")

        if len(package) > 0:
            self.open_terminal(self.command_installPackage + package.split(' ')[0], True)
            self.rebuild_notice()

    def remove_package(self):
        self.message_open('Collecting list of installed packages')
        if self.detected_packageManager == 'apt-get':
            packages = self.installedPackages_aptget()
        elif self.detected_packageManager == 'yum':
            packages = self.installedPackages_yum()
        elif self.detected_packageManager == 'dnf':
            packages = self.installedPackages_dnf()
        elif self.detected_packageManager == 'pacman':
            packages = self.installedPackages_pacman()
        elif self.detected_packageManager == 'portage':
            packages = self.u_installedPackages_portage()

        self.message_close()

        package = self.select(packages, prompt="Uninstall:")
        if package is not -1:
            self.open_terminal(self.command_removePackage + package, True)
            self.rebuild_notice()

    def update_package(self):
        self.message_open('Collecting list of installed packages')

        if self.detected_packageManager == 'apt-get':
            packages = self.installedPackages_aptget()
        elif self.detected_packageManager == 'yum':
            packages = self.installedPackages_yum()
        elif self.detected_packageManager == 'dnf':
            packages = self.installedPackages_dnf()
        elif self.detected_packageManager == 'pacman':
            packages = self.installedPackages_pacman()
        elif self.detected_packageManager == 'portage':
            packages = self.installedPackages_portage()

        self.message_close()

        package = self.select(packages, prompt="Update:")
        if package is not -1:
            self.open_terminal(self.command_installPackage + package, True)

    def build_package_cache(self, message=True):
        if message:
            self.message_open('Building package cache')

        if self.detected_packageManager == 'apt-get':
            packages = self.availablePackages_aptget()
        elif self.detected_packageManager == 'yum':
            packages = self.availablePackages_yum()
        elif self.detected_packageManager == 'dnf':
            packages = self.availablePackages_dnf()
        elif self.detected_packageManager == 'pacman':
            packages = self.availablePackages_pacman()
        elif self.detected_packageManager == 'portage':
            packages = self.availablePackages_portage()

        self.cache_save(packages, self.cache_packages)
        if message:
            self.message_close()
            self.menu("Package cache built")

    def update_system(self):
        self.open_terminal(self.command_systemUpdate, True)

    def installedPackages_aptget(self):
        packages = self.command_output(self.command_listInstalled)
        out = []
        for package in packages:
            tmp = package.split()
            if len(tmp) > 6:
                out.append(tmp[1])
        out.sort()
        return list(set(out))

    def installedPackages_yum(self):
        packages = self.command_output(self.command_listInstalled)
        packages.sort()
        return list(set(packages))
    
    def installedPackages_dnf(self):
        packages = self.command_output(self.command_listInstalled)
        packages.sort()
        return list(set(packages))

    def installedPackages_pacman(self):
        packages = self.command_output(self.command_listInstalled)
        out = []
        for package in packages:
            if len(package) > 0 and package[0] != " ":
                out.append(package.split(' ')[0])
        out.sort()
        return list(set(out))

    def installedPackages_portage(self):
        os.system(self.command_listInstalled)
        packages = self.command_output('cat ' + dmenu_extended.path_cache + '/tmp.txt')
        os.system('rm '  + dmenu_extended.path_cache + '/tmp.txt')
        return packages

    def u_installedPackages_portage(self):
        os.system('cd /var/db/pkg/ && ls -d */* > ' + dmenu_extended.path_cache + '/tmp.txt')
        packages = self.command_output('cat ' + dmenu_extended.path_cache + '/tmp.txt')
        os.system('rm '  + dmenu_extended.path_cache + '/tmp.txt')
        return packages

    def availablePackages_aptget(self):
        packages = self.command_output(self.command_listAvailable)
        packages.sort()
        return packages

    def availablePackages_yum(self):
        packages = self.command_output(self.command_listAvailable)
        out = []
        last = ""
        for package in packages:
            tmp = package.split( ' : ' )
            if len(tmp) > 1:
                if tmp[0][0] == " ":
                    last += " " + tmp[1]
                else:
                    out.append(last)
                    last = tmp[0].split('.')[0] + ' - ' + tmp[1]

        out.append(last)
        out.sort()
        return list(set(out[1:]))
    
    def availablePackages_dnf(self):
        packages = self.command_output(self.command_listAvailable)
        out = []
        last = ""
        for package in packages:
            tmp = package.split( ' : ' )
            if len(tmp) > 1:
                if tmp[0][0] == " ":
                    last += " " + tmp[1]
                else:
                    out.append(last)
                    last = tmp[0].split('.')[0] + ' - ' + tmp[1]

        out.append(last)
        out.sort()
        return list(set(out[1:]))

    def availablePackages_pacman(self):
        packages = self.command_output(self.command_listAvailable)
        out = []
        last = ""
        for package in packages:
            if package != "":
                if package[0:3] == "   ":
                    last += " - " + package[4:]
                else:
                    out.append(last)
                    last = package
        out.append(last)
        out.sort()
        return list(set(out[1:]))

    def availablePackages_portage(self):
        os.system(self.command_listAvailable)
        packages = self.command_output('cat ' + dmenu_extended.path_cache + '/tmp.txt')
        os.system('rm '  + dmenu_extended.path_cache + '/tmp*')
        return packages

    def rebuild_notice(self):
        # gnome-termainal forks from the calling process so this message shows
        # before the action has completed.
        if self.prefs['terminal'] != 'gnome-terminal':
            rebuild = self.menu(["Cache may be out-of-date, rebuild at your convenience.", "* Rebuild cache now"])
            if rebuild == "* Rebuild cache now":
                self.cache_regenerate()

    def run(self, inputText):

        if self.detected_packageManager == False:
            self.menu(["Your system package manager could not be determined"])
            self.sys.exit()
        else:
            print('Detected system package manager as ' + str(self.detected_packageManager))

        items = [self.prefs['indicator_submenu'] + ' Install a new package',
                 self.prefs['indicator_submenu'] + ' Uninstall a package',
                 self.prefs['indicator_submenu'] + ' Update a package',
                 'Rebuild the package cache',
                 'Perform system upgrade']

        selectedIndex = self.select(items, prompt='Action:', numeric=True)

        if selectedIndex != -1:
            if selectedIndex == 0:
                self.install_package()
            elif selectedIndex == 1:
                self.remove_package()
            elif selectedIndex == 2:
                self.update_package()
            elif selectedIndex == 3:
                self.build_package_cache()
            elif selectedIndex == 4:
                self.update_system()
