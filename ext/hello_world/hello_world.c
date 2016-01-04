#include <ruby.h>

int hello_world()
{
	return 4225;
}

void Init_hello_world()
{
    VALUE HelloWorldModule = rb_define_module("HelloWorld");
    rb_global_variable(&HelloWorldModule);
}