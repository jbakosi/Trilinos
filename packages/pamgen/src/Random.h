// $Id$


// the system defined random number generator
#if defined(_MSC_VER) || defined(__CYGWIN__)
# define SRANDOM(i) srand(i)
# define RANDOM() rand()
#else
# define SRANDOM(i) srandom(i)
# define RANDOM() random()
#endif
