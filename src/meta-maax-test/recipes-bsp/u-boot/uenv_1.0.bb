SUMMARY = "U-Boot Env"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"
SECTION = "BSP"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

PACKAGES += "${PN}-bootfs"

S = "${WORKDIR}"

SRC_URI = " \
            file://uEnv-t.txt \
"
FILES_${PN} = "/boot"

do_install () {
    install -d ${D}/boot
    install -m 0644 ${S}/uEnv-*.txt ${D}/boot/uEnv.txt
}

inherit deploy
addtask deploy after do_install

do_deploy () {
    install -m 0644 ${D}/boot/uEnv.txt ${DEPLOYDIR}
}

COMPATIBLE_MACHINE = "(maaxboardbase)"
PACKAGE_ARCH = "${MACHINE_ARCH}"