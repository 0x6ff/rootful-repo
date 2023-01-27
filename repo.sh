

rm Packages Packages.bz2 Packages.xz Packages.zst Release Release.gpg

echo "[Repository] Generating Packages..."
apt-ftparchive packages ./pool > Packages
zstd -q -c19 Packages > Packages.zst
xz -c9 Packages > Packages.xz
bzip2 -c9 Packages > Packages.bz2

echo "[Repository] Generating Release..."
apt-ftparchive \
		-o APT::FTPArchive::Release::Origin="Hephaestus/Ironside" \
		-o APT::FTPArchive::Release::Label="Hephaestus/Ironside" \
		-o APT::FTPArchive::Release::Suite="stable" \
		-o APT::FTPArchive::Release::Version="1.0r2" \
		-o APT::FTPArchive::Release::Codename="ios" \
		-o APT::FTPArchive::Release::Architectures="iphoneos-arm" \
		-o APT::FTPArchive::Release::Components="main" \
		-o APT::FTPArchive::Release::Support: "https://repo.ironside.org.uk/" \
		-o APT::FTPArchive::Release::Depiction: "https://repo.ironside.org.uk/info/*" \
		-o APT::FTPArchive::Release::Description="Distribution of Unix Software for iPhoneOS" \
		release . > Release

echo "[Repository] Signing Release using Azreal's GPG Key..."
gpg -abs -u CF54D55308002E111D67927C7986FCBCA185214F -o Release.gpg Release

echo "[Repository] Finished"
