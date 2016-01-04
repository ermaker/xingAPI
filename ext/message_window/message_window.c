#include <ruby.h>
#include <windows.h>
#include <stdio.h>

static VALUE MessageWindow;
static VALUE queue;
static VALUE hwnd;

LRESULT CALLBACK message_to_queue(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
  // rb_eval_string("puts 'message_to_queue'");
  // rb_eval_string("$_message_window_queue.push 'test'");
  // rb_funcall(queue, rb_intern("push"), 4,
  //   INT2NUM((int)hwnd), INT2NUM(uMsg), INT2NUM(wParam), INT2NUM(lParam));
  
  // rb_funcall(queue, rb_intern("push"), 1,
  //   INT2NUM(uMsg));
  printf("WM  : %x %x %x %x\n", (unsigned int)hwnd, uMsg, wParam, (unsigned int)lParam);
  return DefWindowProc(hwnd, uMsg, wParam, lParam);
}

HWND make_window()
{
    HMODULE hInstance = GetModuleHandle(NULL);
    int nCmdShow = 1;

    // Register the window class.
    const char CLASS_NAME[]  = "Sample Window Class";
    
    WNDCLASS wc = { };

    wc.lpfnWndProc   = DefWindowProc;
    wc.lpfnWndProc   = message_to_queue;
    wc.hInstance     = hInstance;
    wc.lpszClassName = CLASS_NAME;

    RegisterClass(&wc);

    // Create the window.

    HWND hwnd = CreateWindowExA(
        0,                              // Optional window styles.
        CLASS_NAME,                     // Window class
        "Learn to Program Windows",    // Window text
        WS_OVERLAPPEDWINDOW,            // Window style

        // Size and position
        CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,

        NULL,       // Parent window    
        NULL,       // Menu
        hInstance,  // Instance handle
        NULL        // Additional application data
        );

    if (hwnd == NULL)
    {
        return 0;
    }

    ShowWindow(hwnd, nCmdShow);

    return hwnd;
}

HWND xmake_window()
{
  HMODULE instance;
  WNDCLASSEX window_class;
  HWND hwnd;
  const char class_name[]  = "xingAPI ruby";

  instance = GetModuleHandle(NULL);
  window_class.style = CS_HREDRAW | CS_VREDRAW;
  window_class.lpfnWndProc = message_to_queue;
  window_class.hInstance = instance;
  window_class.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
  window_class.lpszClassName = class_name;

  RegisterClassExA(&window_class);

/*
  hwnd = CreateWindowExA(
    WS_EX_LEFT, class_name, "xingAPI-ruby",
    WS_OVERLAPPEDWINDOW, 0, 0, 0, 0,
    NULL, NULL, instance, NULL);
*/

  hwnd = CreateWindowExA(
    0, class_name, "xingAPI ruby",
    WS_OVERLAPPEDWINDOW, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,
    NULL, NULL, instance, NULL);

  return hwnd;
}

DWORD WINAPI pump(LPVOID lpParam)
{
  /*
  rb_eval_string("puts 'pump WORKS!!'");
  rb_eval_string("puts 'pump WORKS!!'");
  rb_eval_string("puts 'pump WORKS!!'");
  rb_eval_string("puts 'pump WORKS!!'");
  rb_eval_string("puts 'pump WORKS!!'");

  return 0;
  */

  MSG msg = { };
  printf("pump STARTED\n");
  while (GetMessage(&msg, NULL, 0, 0))
  // while (PeekMessage(&msg, NULL, 0, 0, PM_REMOVE))
  // while (WaitMessage())
  {
    // GetMessage(&msg, NULL, 0, 0);
    printf("PUMP: %x %x %x %x\n", (unsigned int)msg.hwnd, msg.message, msg.wParam, (unsigned int)msg.lParam);
    TranslateMessage(&msg);
    DispatchMessage(&msg);
    sleep(1);
  }
  printf("pump FINISHED\n");
  // rb_eval_string("puts 'pump FINISHED'");
  return 0;
}

void test_pump()
{
  MSG msg = { };
  printf("PUMP started\n");
  while (GetMessage(&msg, NULL, 0, 0))
  {
    printf("PUMP: %x %x %x %x\n", (unsigned int)msg.hwnd, msg.message, msg.wParam, (unsigned int)msg.lParam);
    TranslateMessage(&msg);
    DispatchMessage(&msg);
  }
  printf("PUMP finished\n");
  return 0;
}

DWORD WINAPI test_thread(LPVOID lpParam)
{
  HWND hwnd_ = make_window();
  printf("hwnd: %x\n", hwnd_);
  hwnd = INT2NUM(hwnd_);
  test_pump();
  return 0;
}

VALUE test_(VALUE self)
{
  HANDLE handle = CreateThread( 
    NULL,
    0,
    test_thread,
    NULL,
    0,
    NULL);
  return INT2NUM((int)handle);
}

VALUE create_(VALUE self)
{
  HWND hwnd = make_window();
  return INT2NUM((int)hwnd);
}

VALUE pump_(VALUE self)
{
  return rb_thread_call_without_gvl2(pump, 0);
  HANDLE handle = CreateThread( 
    NULL,
    0,
    pump,
    NULL,
    0,
    NULL);
  return INT2NUM((int)handle);
}

VALUE queue_(VALUE self)
{
  // return rb_cv_get(MessageWindow, "@@queue");
  // return rb_const_get(MessageWindow, rb_intern("QUEUE"));
  return queue;
}

void Init_message_window()
{
  VALUE rb_cQueue;

  rb_cQueue = rb_const_get(rb_cObject, rb_intern("Queue"));
  // rb_cQueue = rb_const_get(rb_cObject, rb_intern("Array"));
  queue = rb_funcall(rb_cQueue, rb_intern("new"), 0);
  // queue = rb_eval_string("Queue.new");
  // rb_define_class_variable(MessageWindow, "@@queue", queue);
  // rb_cv_set(MessageWindow, "@@queue", queue);
  // rb_define_const(MessageWindow, "QUEUE", queue);
  rb_define_variable("$_message_window_queue", &queue);
  rb_define_variable("$_message_window_hwnd", &hwnd);

  MessageWindow = rb_define_class("MessageWindow" , rb_cObject);
  rb_define_method(MessageWindow, "create", create_, 0);
  rb_define_method(MessageWindow, "pump", pump_, 0);
  rb_define_method(MessageWindow, "test_", test_, 0);
  rb_define_method(MessageWindow, "queue", queue_, 0);
}
