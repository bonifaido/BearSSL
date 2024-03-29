# Set the path to the Kernel build utils.
KBUILD=/lib/modules/$(shell uname -r)/build/

ccflags-y += -Ofast -ffreestanding
ARCH := $(shell uname -m)
ifeq ($(ARCH), aarch64)
	ccflags-remove-y += -mgeneral-regs-only
endif

LD = ld
VERBOSE ?= 0

linux-km:
	$(MAKE) -C $(KBUILD) M=$(PWD) V=$(VERBOSE) modules

linux-km-clean:
	$(MAKE) -C $(KBUILD) M=$(PWD) clean

linux-km-help:
	$(MAKE) -C $(KBUILD) M=$(PWD) help

# obj-m specifies we're a kernel module.
obj-m += bearssl.o
bearssl-objs := src/linuxkm.o \
			 src/kdf/shake.o \
			 src/kdf/hkdf.o \
			 src/ssl/ssl_hashes.o \
			 src/ssl/ssl_scert_single_ec.o \
			 src/ssl/ssl_engine_default_rsavrfy.o \
			 src/ssl/prf.o \
			 src/ssl/ssl_engine_default_ecdsa.o \
			 src/ssl/ssl_server_minf2c.o \
			 src/ssl/ssl_server_mine2g.o \
			 src/ssl/ssl_io.o \
			 src/ssl/ssl_server_minr2g.o \
			 src/ssl/ssl_server_mine2c.o \
			 src/ssl/ssl_engine.o \
			 src/ssl/ssl_hs_client.o \
			 src/ssl/ssl_engine_default_aesccm.o \
			 src/ssl/ssl_rec_ccm.o \
			 src/ssl/ssl_server_minf2g.o \
			 src/ssl/ssl_client.o \
			 src/ssl/ssl_server_minu2g.o \
			 src/ssl/ssl_rec_gcm.o \
			 src/ssl/ssl_rec_chapol.o \
			 src/ssl/ssl_engine_default_aesgcm.o \
			 src/ssl/ssl_keyexport.o \
			 src/ssl/ssl_engine_default_aescbc.o \
			 src/ssl/ssl_rec_cbc.o \
			 src/ssl/ssl_server_minv2g.o \
			 src/ssl/ssl_engine_default_descbc.o \
			 src/ssl/ssl_lru.o \
			 src/ssl/prf_sha384.o \
			 src/ssl/prf_sha256.o \
			 src/ssl/ssl_server.o \
			 src/ssl/ssl_hs_server.o \
			 src/ssl/ssl_engine_default_ec.o \
			 src/ssl/ssl_client_default_rsapub.o \
			 src/ssl/ssl_engine_default_chapol.o \
			 src/ssl/ssl_scert_single_rsa.o \
			 src/ssl/ssl_ccert_single_rsa.o \
			 src/ssl/ssl_server_full_ec.o \
			 src/ssl/prf_md5sha1.o \
			 src/ssl/ssl_client_full.o \
			 src/ssl/ssl_server_full_rsa.o \
			 src/ssl/ssl_ccert_single_ec.o \
			 src/aead/gcm.o \
			 src/aead/ccm.o \
			 src/aead/eax.o \
			 src/hash/sha2small.o \
			 src/hash/ghash_ctmul32.o \
			 src/hash/mgf1.o \
			 src/hash/sha1.o \
			 src/hash/md5sha1.o \
			 src/hash/dig_size.o \
			 src/hash/multihash.o \
			 src/hash/ghash_pclmul.o \
			 src/hash/ghash_ctmul.o \
			 src/hash/ghash_ctmul64.o \
			 src/hash/sha2big.o \
			 src/hash/ghash_pwr8.o \
			 src/hash/md5.o \
			 src/hash/dig_oid.o \
			 src/codec/enc32le.o \
			 src/codec/dec16le.o \
			 src/codec/dec64be.o \
			 src/codec/dec16be.o \
			 src/codec/enc32be.o \
			 src/codec/dec64le.o \
			 src/codec/enc64le.o \
			 src/codec/dec32be.o \
			 src/codec/enc16be.o \
			 src/codec/pemenc.o \
			 src/codec/ccopy.o \
			 src/codec/pemdec.o \
			 src/codec/enc64be.o \
			 src/codec/enc16le.o \
			 src/codec/dec32le.o \
			 src/rsa/rsa_i31_keygen_inner.o \
			 src/rsa/rsa_default_pss_vrfy.o \
			 src/rsa/rsa_i15_pubexp.o \
			 src/rsa/rsa_i62_pkcs1_vrfy.o \
			 src/rsa/rsa_i31_modulus.o \
			 src/rsa/rsa_i32_pss_sign.o \
			 src/rsa/rsa_i15_oaep_encrypt.o \
			 src/rsa/rsa_i15_pub.o \
			 src/rsa/rsa_pss_sig_pad.o \
			 src/rsa/rsa_default_pub.o \
			 src/rsa/rsa_default_modulus.o \
			 src/rsa/rsa_i31_pub.o \
			 src/rsa/rsa_i62_oaep_encrypt.o \
			 src/rsa/rsa_i31_pkcs1_vrfy.o \
			 src/rsa/rsa_i32_oaep_decrypt.o \
			 src/rsa/rsa_i15_pss_vrfy.o \
			 src/rsa/rsa_i31_keygen.o \
			 src/rsa/rsa_default_oaep_decrypt.o \
			 src/rsa/rsa_i15_pkcs1_vrfy.o \
			 src/rsa/rsa_default_priv.o \
			 src/rsa/rsa_i32_priv.o \
			 src/rsa/rsa_i62_pss_sign.o \
			 src/rsa/rsa_default_pubexp.o \
			 src/rsa/rsa_oaep_unpad.o \
			 src/rsa/rsa_ssl_decrypt.o \
			 src/rsa/rsa_default_keygen.o \
			 src/rsa/rsa_default_pkcs1_sign.o \
			 src/rsa/rsa_pss_sig_unpad.o \
			 src/rsa/rsa_i32_pub.o \
			 src/rsa/rsa_i31_pubexp.o \
			 src/rsa/rsa_i15_privexp.o \
			 src/rsa/rsa_i31_oaep_decrypt.o \
			 src/rsa/rsa_i31_pss_vrfy.o \
			 src/rsa/rsa_i15_keygen.o \
			 src/rsa/rsa_i62_keygen.o \
			 src/rsa/rsa_i32_pkcs1_sign.o \
			 src/rsa/rsa_pkcs1_sig_pad.o \
			 src/rsa/rsa_i31_priv.o \
			 src/rsa/rsa_default_pss_sign.o \
			 src/rsa/rsa_i32_pss_vrfy.o \
			 src/rsa/rsa_i62_pkcs1_sign.o \
			 src/rsa/rsa_i31_oaep_encrypt.o \
			 src/rsa/rsa_i15_priv.o \
			 src/rsa/rsa_i15_pkcs1_sign.o \
			 src/rsa/rsa_i62_pub.o \
			 src/rsa/rsa_default_privexp.o \
			 src/rsa/rsa_pkcs1_sig_unpad.o \
			 src/rsa/rsa_i62_pss_vrfy.o \
			 src/rsa/rsa_i15_pss_sign.o \
			 src/rsa/rsa_i31_pkcs1_sign.o \
			 src/rsa/rsa_i31_privexp.o \
			 src/rsa/rsa_i62_priv.o \
			 src/rsa/rsa_default_oaep_encrypt.o \
			 src/rsa/rsa_i62_oaep_decrypt.o \
			 src/rsa/rsa_i32_oaep_encrypt.o \
			 src/rsa/rsa_default_pkcs1_vrfy.o \
			 src/rsa/rsa_oaep_pad.o \
			 src/rsa/rsa_i15_modulus.o \
			 src/rsa/rsa_i31_pss_sign.o \
			 src/rsa/rsa_i32_pkcs1_vrfy.o \
			 src/rsa/rsa_i15_oaep_decrypt.o \
			 src/ec/ec_p256_m62.o \
			 src/ec/ec_keygen.o \
			 src/ec/ec_prime_i31.o \
			 src/ec/ec_default.o \
			 src/ec/ecdsa_i31_vrfy_asn1.o \
			 src/ec/ec_c25519_m62.o \
			 src/ec/ecdsa_atr.o \
			 src/ec/ecdsa_i15_vrfy_asn1.o \
			 src/ec/ec_c25519_m31.o \
			 src/ec/ec_c25519_i31.o \
			 src/ec/ec_curve25519.o \
			 src/ec/ec_all_m31.o \
			 src/ec/ec_p256_m31.o \
			 src/ec/ecdsa_default_sign_asn1.o \
			 src/ec/ecdsa_rta.o \
			 src/ec/ec_p256_m64.o \
			 src/ec/ecdsa_i15_vrfy_raw.o \
			 src/ec/ec_c25519_m15.o \
			 src/ec/ec_all_m15.o \
			 src/ec/ec_c25519_m64.o \
			 src/ec/ecdsa_i31_sign_asn1.o \
			 src/ec/ecdsa_i15_sign_raw.o \
			 src/ec/ec_c25519_i15.o \
			 src/ec/ec_secp384r1.o \
			 src/ec/ec_p256_m15.o \
			 src/ec/ecdsa_i15_sign_asn1.o \
			 src/ec/ecdsa_i31_vrfy_raw.o \
			 src/ec/ecdsa_default_sign_raw.o \
			 src/ec/ec_secp256r1.o \
			 src/ec/ecdsa_i31_bits.o \
			 src/ec/ec_prime_i15.o \
			 src/ec/ecdsa_i15_bits.o \
			 src/ec/ecdsa_default_vrfy_asn1.o \
			 src/ec/ec_secp521r1.o \
			 src/ec/ecdsa_default_vrfy_raw.o \
			 src/ec/ec_pubkey.o \
			 src/ec/ecdsa_i31_sign_raw.o \
			 src/x509/asn1enc.o \
			 src/x509/encode_ec_rawder.o \
			 src/x509/x509_minimal_full.o \
			 src/x509/encode_rsa_rawder.o \
			 src/x509/x509_minimal.o \
			 src/x509/x509_knownkey.o \
			 src/x509/skey_decoder.o \
			 src/x509/encode_rsa_pk8der.o \
			 src/x509/encode_ec_pk8der.o \
			 src/x509/x509_decoder.o \
			 src/mac/hmac.o \
			 src/mac/hmac_ct.o \
			 src/int/i32_bitlen.o \
			 src/int/i31_fmont.o \
			 src/int/i31_decred.o \
			 src/int/i15_rshift.o \
			 src/int/i62_modpow2.o \
			 src/int/i32_decmod.o \
			 src/int/i31_encode.o \
			 src/int/i32_iszero.o \
			 src/int/i31_mulacc.o \
			 src/int/i15_modpow2.o \
			 src/int/i32_muladd.o \
			 src/int/i15_reduce.o \
			 src/int/i31_decode.o \
			 src/int/i15_decred.o \
			 src/int/i31_rshift.o \
			 src/int/i32_modpow.o \
			 src/int/i32_fmont.o \
			 src/int/i31_reduce.o \
			 src/int/i15_decode.o \
			 src/int/i15_fmont.o \
			 src/int/i31_ninv31.o \
			 src/int/i31_montmul.o \
			 src/int/i15_encode.o \
			 src/int/i32_div32.o \
			 src/int/i15_mulacc.o \
			 src/int/i31_muladd.o \
			 src/int/i32_ninv32.o \
			 src/int/i32_decode.o \
			 src/int/i31_decmod.o \
			 src/int/i31_tmont.o \
			 src/int/i31_iszero.o \
			 src/int/i32_encode.o \
			 src/int/i15_montmul.o \
			 src/int/i32_mulacc.o \
			 src/int/i15_moddiv.o \
			 src/int/i32_decred.o \
			 src/int/i31_sub.o \
			 src/int/i15_modpow.o \
			 src/int/i15_add.o \
			 src/int/i31_add.o \
			 src/int/i31_bitlen.o \
			 src/int/i32_montmul.o \
			 src/int/i15_sub.o \
			 src/int/i15_iszero.o \
			 src/int/i15_decmod.o \
			 src/int/i32_tmont.o \
			 src/int/i32_reduce.o \
			 src/int/i15_muladd.o \
			 src/int/i31_modpow2.o \
			 src/int/i15_tmont.o \
			 src/int/i15_bitlen.o \
			 src/int/i15_ninv15.o \
			 src/int/i31_modpow.o \
			 src/int/i32_add.o \
			 src/int/i32_sub.o \
			 src/int/i31_moddiv.o \
			 src/symcipher/des_tab_cbcdec.o \
			 src/symcipher/aes_ct64.o \
			 src/symcipher/aes_big_cbcenc.o \
			 src/symcipher/aes_pwr8_cbcdec.o \
			 src/symcipher/aes_ct_ctr.o \
			 src/symcipher/des_ct.o \
			 src/symcipher/aes_x86ni_ctrcbc.o \
			 src/symcipher/aes_small_ctrcbc.o \
			 src/symcipher/des_ct_cbcenc.o \
			 src/symcipher/poly1305_ctmul32.o \
			 src/symcipher/aes_big_ctr.o \
			 src/symcipher/aes_ct_ctrcbc.o \
			 src/symcipher/des_ct_cbcdec.o \
			 src/symcipher/poly1305_ctmulq.o \
			 src/symcipher/aes_ct64_ctrcbc.o \
			 src/symcipher/aes_pwr8_cbcenc.o \
			 src/symcipher/chacha20_ct.o \
			 src/symcipher/aes_big_cbcdec.o \
			 src/symcipher/aes_small_ctr.o \
			 src/symcipher/aes_x86ni.o \
			 src/symcipher/des_tab_cbcenc.o \
			 src/symcipher/aes_ct64_ctr.o \
			 src/symcipher/des_support.o \
			 src/symcipher/aes_big_ctrcbc.o \
			 src/symcipher/aes_small_dec.o \
			 src/symcipher/aes_x86ni_ctr.o \
			 src/symcipher/aes_common.o \
			 src/symcipher/aes_ct64_dec.o \
			 src/symcipher/des_tab.o \
			 src/symcipher/aes_big_dec.o \
			 src/symcipher/aes_pwr8.o \
			 src/symcipher/aes_small_cbcenc.o \
			 src/symcipher/aes_ct_cbcdec.o \
			 src/symcipher/chacha20_sse2.o \
			 src/symcipher/aes_ct_enc.o \
			 src/symcipher/aes_x86ni_cbcenc.o \
			 src/symcipher/poly1305_ctmul.o \
			 src/symcipher/aes_ct64_cbcdec.o \
			 src/symcipher/aes_pwr8_ctr.o \
			 src/symcipher/poly1305_i15.o \
			 src/symcipher/aes_ct64_cbcenc.o \
			 src/symcipher/aes_x86ni_cbcdec.o \
			 src/symcipher/aes_ct_dec.o \
			 src/symcipher/aes_ct_cbcenc.o \
			 src/symcipher/aes_small_cbcdec.o \
			 src/symcipher/aes_ct.o \
			 src/symcipher/aes_big_enc.o \
			 src/symcipher/aes_ct64_enc.o \
			 src/symcipher/aes_small_enc.o \
			 src/symcipher/aes_pwr8_ctrcbc.o \
			 src/settings.o \
			 src/rand/sysrng.o \
			 src/rand/aesctr_drbg.o \
			 src/rand/hmac_drbg.o \
