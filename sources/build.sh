#!/bin/sh
set -e

cd sources

echo "Generating Static fonts"
mkdir -p ../fonts
fontmake -g LibreCaslonText.glyphs -i -o ttf --output-dir ../fonts
fontmake -g LibreCaslonText-Italic.glyphs -i -o ttf --output-dir ../fonts

echo "Generating VFs"
fontmake -g LibreCaslonText.glyphs -o variable --output-path ../fonts/LibreCaslonText-Roman-VF.ttf

rm -rf master_ufo/ instance_ufo/


echo "Post processing"
ttfs=$(ls ../fonts/*.ttf)
for ttf in $ttfs
do
	gftools fix-dsig -f $ttf;
	gftools fix-nonhinting $ttf "$ttf.fix";
	mv "$ttf.fix" $ttf;
done

echo "Post processing VFs"
vfs=$(ls ../fonts/*-VF.ttf)
for vf in $vfs
do
	gftools fix-dsig -f $vf;
	gftools fix-nonhinting $vf "$vf.fix";
	mv "$vf.fix" $vf;
done
rm ../fonts/*backup*.ttf

echo "Fixing VF Meta"
gftools fix-vf-meta $vfs;
for vf in $vfs
do
	mv "$vf.fix" $vf;
	ttx -f -x "MVAR" $vf; # Drop MVAR. Table has issue in DW
	rtrip=$(basename -s .ttf $vf)
	new_file=../fonts/$rtrip.ttx;
	rm $vf;
	ttx $new_file
	rm $new_file
done

