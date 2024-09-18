for name in (flatpak remotes --columns=name | lines | filter { $in != "" }) {
	print $"flatpak remote-delete ($name)"
	sudo flatpak remote-delete $name
}

# https://flatpak.org/setup/
print "sudo flatpak remote-add flathub https://dl.flathub.org/repo/flathub.flatpakrepo"
sudo flatpak remote-add flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# https://mirror.sjtu.edu.cn/docs/flathub
let sjtu_remote_name = "sjtu"
let gpg_file_path = "/tmp/flathub.gpg"

if (not ($gpg_file_path | path exists)) {
	print $"wget https://mirror.sjtu.edu.cn/flathub/flathub.gpg -P /tmp"
	wget https://mirror.sjtu.edu.cn/flathub/flathub.gpg -P /tmp
}
print $"sudo flatpak remote-add ($sjtu_remote_name) https://mirror.sjtu.edu.cn/flathub --gpg-import=($gpg_file_path)"
sudo flatpak remote-add $sjtu_remote_name https://mirror.sjtu.edu.cn/flathub ($"--gpg-import=($gpg_file_path)")

print "\n"
flatpak remotes
