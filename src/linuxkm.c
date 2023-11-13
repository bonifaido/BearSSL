#include <linux/module.h>
#include "inner.h"

EXPORT_SYMBOL(br_ssl_server_init_full_rsa);
EXPORT_SYMBOL(br_ssl_server_init_full_ec);
EXPORT_SYMBOL(br_ssl_client_init_full);
EXPORT_SYMBOL(br_ssl_engine_set_buffer);
EXPORT_SYMBOL(br_ssl_server_reset);
EXPORT_SYMBOL(br_ssl_client_reset);
EXPORT_SYMBOL(br_ssl_engine_recvapp_buf);
EXPORT_SYMBOL(br_ssl_engine_recvapp_ack);
EXPORT_SYMBOL(br_sslio_init);
EXPORT_SYMBOL(br_sslio_run_until);
EXPORT_SYMBOL(br_sslio_read);
EXPORT_SYMBOL(br_sslio_write_all);
EXPORT_SYMBOL(br_sslio_flush);
EXPORT_SYMBOL(br_sslio_close);
EXPORT_SYMBOL(br_ssl_engine_close);
EXPORT_SYMBOL(br_ssl_client_set_single_rsa);
EXPORT_SYMBOL(br_rsa_pkcs1_sign_get_default);
EXPORT_SYMBOL(br_x509_minimal_init_full);
EXPORT_SYMBOL(br_ssl_engine_set_default_rsavrfy);
EXPORT_SYMBOL(br_rsa_keygen_get_default);
EXPORT_SYMBOL(br_hmac_drbg_init);
EXPORT_SYMBOL(br_encode_rsa_pkcs8_der);
EXPORT_SYMBOL(br_sha256_vtable);
EXPORT_SYMBOL(br_rsa_compute_privexp_get_default);
EXPORT_SYMBOL(br_prng_seeder_system);
EXPORT_SYMBOL(br_x509_decoder_init);
EXPORT_SYMBOL(br_x509_decoder_push);

static int __init bearssl_init(void)
{
    return 0;
}

static void __exit bearssl_exit(void)
{
}

module_init(bearssl_init);
module_exit(bearssl_exit);

MODULE_LICENSE("Dual MIT/GPL");
