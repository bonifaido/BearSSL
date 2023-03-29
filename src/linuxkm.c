#include <linux/module.h>
#include "inner.h"

EXPORT_SYMBOL(br_ssl_server_init_full_rsa);
EXPORT_SYMBOL(br_ssl_client_init_full);
EXPORT_SYMBOL(br_ssl_engine_set_buffer);
EXPORT_SYMBOL(br_ssl_server_reset);
EXPORT_SYMBOL(br_sslio_init);
EXPORT_SYMBOL(br_sslio_read);
EXPORT_SYMBOL(br_sslio_write_all);
EXPORT_SYMBOL(br_sslio_close);

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
