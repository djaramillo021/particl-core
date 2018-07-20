package=zeromq
$(package)_version=4.2.5
$(package)_download_path=https://github.com/zeromq/libzmq/releases/download/v$($(package)_version)/
$(package)_file_name=$(package)-$($(package)_version).tar.gz
$(package)_sha256_hash=cc9090ba35713d59bb2f7d7965f877036c49c5558ea0c290b0dcc6f2a17e489f
$(package)_patches=0001-fix-build-with-older-mingw64.patch 0002-disable-pthread_set_name_np.patch
$(package)_dependencies=libsodium

define $(package)_set_vars
  $(package)_config_opts=--without-docs --disable-shared --with-libsodium --enable-curve --disable-perf --disable-Werror
  $(package)_config_opts_linux=--with-pic
  $(package)_cxxflags=-std=c++11
endef

define $(package)_preprocess_cmds
   patch -p1 < $($(package)_patch_dir)/0001-fix-build-with-older-mingw64.patch && \
   patch -p1 < $($(package)_patch_dir)/0002-disable-pthread_set_name_np.patch && \
   cp -f $(BASEDIR)/config.guess $(BASEDIR)/config.sub config
endef

define $(package)_config_cmds
  $($(package)_autoconf)
endef

define $(package)_build_cmds
  $(MAKE) src/libzmq.la
endef

define $(package)_stage_cmds
  $(MAKE) DESTDIR=$($(package)_staging_dir) install-libLTLIBRARIES install-includeHEADERS install-pkgconfigDATA
endef

define $(package)_postprocess_cmds
  sed -i.old "s/ -lstdc++//" lib/pkgconfig/libzmq.pc && \
  rm -rf bin share
endef
