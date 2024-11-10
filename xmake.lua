set_xmakever("2.9.3")

set_project("ProjectName")

add_rules("mode.debug", "mode.release")
set_languages("clatest")

option("override_runtime", {description = "Override VS runtime to MD in release and MDd in debug.", default = true})

add_includedirs("Include")

add_rules("plugin.vsxmake.autoupdate")

if is_mode("release") then
  set_fpmodels("fast")
  set_optimize("fastest")
  set_symbols("hidden")
else
  set_symbols("debug")
  add_defines("PN_DEBUG")
end

set_encodings("utf-8")
set_languages("clatest")
set_rundir("./bin/$(plat)_$(arch)_$(mode)")
set_targetdir("./bin/$(plat)_$(arch)_$(mode)")
set_warnings("allextra")

if is_plat("windows") then
  if has_config("override_runtime") then
    set_runtimes(is_mode("debug") and "MDd" or "MD")
  end
end

add_cxflags("-Wno-missing-field-initializers -Werror=vla", {tools = {"clang", "gcc"}})

target("ProjectName")
  set_kind("binary")
  
  add_files("Source/**.c")

  for _, ext in ipairs({".h", ".inl"}) do
    add_headerfiles("Include/**" .. ext)
  end
  
  add_rpathdirs("$ORIGIN")

includes("xmake/**.lua")
