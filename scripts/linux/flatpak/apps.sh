APP_IDS_FROM_FLATHUB=(
	"org.telegram.desktop"
)
APP_IDS_FROM_SJTU=(
	"com.github.tchx84.Flatseal"
	"com.microsoft.Edge"
	"com.qq.QQ"
    "com.mattjakeman.ExtensionManager"
    "io.github.flattool.Warehouse"
)
APP_IDS=(
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

for id in "${APP_IDS[@]}"
do
	CMD="flatpak install ${id}"
	echo $CMD
	eval $CMD
done
