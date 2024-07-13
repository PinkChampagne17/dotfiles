APP_IDS_FROM_FLATHUB=(
	"io.github.kukuruzka165.materialgram"
)
APP_IDS_FROM_SJTU=(
	"app.devsuite.Ptyxis"
	"com.qq.QQ"
	"com.microsoft.Edge"
	"com.valvesoftware.Steam"
	"org.freedesktop.Piper"
	"org.gnome.baobab"
)

for id in "${APP_IDS_FROM_FLATHUB[@]}"
do
	CMD="flatpak install flathub ${id}"
	echo $CMD
	eval $CMD
done

for id in "${APP_IDS_FROM_SJTU[@]}"
do
	CMD="flatpak install sjtu ${id}"
	echo $CMD
	eval $CMD
done
