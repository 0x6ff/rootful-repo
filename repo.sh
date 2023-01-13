

rm Packages Packages.bz2 Packages.xz Packages.zst Release Release.gpg

echo "[Repository] Generating Packages..."
apt-ftparchive packages ./pool > Packages
zstd -q -c19 Packages > Packages.zst
xz -c9 Packages > Packages.xz
bzip2 -c9 Packages > Packages.bz2

echo "[Repository] Generating Release..."
apt-ftparchive \
		-o APT::FTPArchive::Release::Origin="Dev Team" \
		-o APT::FTPArchive::Release::Label="Dev Team" \
		-o APT::FTPArchive::Release::Suite="stable" \
		-o APT::FTPArchive::Release::Version="3.0" \
		-o APT::FTPArchive::Release::Codename="ios" \
		-o APT::FTPArchive::Release::Architectures="iphoneos-arm" \
		-o APT::FTPArchive::Release::Components="main" \
		-o APT::FTPArchive::Release::Description="A parody of the old Dev Team repo which had ultrasn0w." \
		release . > Release

echo "[Repository] Signing Release using Azreal's GPG Key..."
gpg -abs -u DA2AF8284E071C1791102722BE2BED001FB080C2 -o Release.gpg Release

echo "[Repository] Finished"
