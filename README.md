# RomikB

Welcome! It's an overlay for gentoo.

# How to?

First of all, get a machine with gentoo. Then:

`emerge eselect-repository`

(optional) `eselect repository add RomikB git https://github.com/RomikB/gentoo-repository.git`

`eselect repository enable RomikB`

`emaint sync -r RomikB`
