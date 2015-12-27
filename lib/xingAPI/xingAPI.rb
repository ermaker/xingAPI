require 'ffi'

module XingAPI
  module XingAPI
    extend FFI::Library
    ffi_lib 'xingAPI'
    ffi_convention :stdcall

    attach_function :ETK_Connect, [:ulong, :string, :int, :int, :int, :int ], :bool
    attach_function :ETK_IsConnected, [], :bool
    attach_function :ETK_Disconnect, [], :bool

    attach_function :ETK_Login, [:ulong, :string, :string, :string, :int, :bool], :bool
    attach_function :ETK_Logout, [:ulong], :bool

    attach_function :ETK_Request, [:ulong, :string, :pointer, :int, :bool, :string, :int], :int
    attach_function :ETK_ReleaseRequestData, [:int], :void
    attach_function :ETK_ReleaseMessageData, [:long], :void

    attach_function :ETK_GetAccountListCount, [], :int
    attach_function :ETK_GetAccountList, [:int, :pointer, :int], :bool

    attach_function :ETK_GetClientIP, [:pointer], :void
    attach_function :ETK_GetServerName, [:pointer], :void

    attach_function :ETK_GetLastError, [], :int
    attach_function :ETK_GetErrorMessage, [], :int
  end
end