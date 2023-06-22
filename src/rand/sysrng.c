/*
 * Copyright (c) 2017 Thomas Pornin <pornin@bolet.org>
 *
 * Permission is hereby granted, free of charge, to any person obtaining 
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be 
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#define BR_ENABLE_INTRINSICS   1
#include "../inner.h"

#if BR_USE_GETENTROPY
#include <unistd.h>
#endif

#if BR_USE_URANDOM
#include <linux/random.h>
#endif

#if BR_USE_WIN32_RAND
#include <windows.h>
#include <wincrypt.h>
#pragma comment(lib, "advapi32")
#endif

/*
 * Seeder that uses getentropy() (backed by getrandom() on some systems,
 * e.g. Linux). On failure, it will use the /dev/urandom seeder (if
 * enabled).
 */
static int
seeder_getentropy(const br_prng_class **ctx)
{
	unsigned char tmp[32];

	get_random_bytes(tmp, sizeof tmp);
	(*ctx)->update(ctx, tmp, sizeof tmp);
	return 1;
}

/* see bearssl_rand.h */
br_prng_seeder
br_prng_seeder_system(const char **name)
{
	if (name != NULL) {
		*name = "getentropy";
	}
	return &seeder_getentropy;
}
