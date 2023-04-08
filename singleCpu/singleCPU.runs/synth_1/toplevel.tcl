# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7k70tfbv676-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/hejsh/Desktop/singleCPU/singleCPU.cache/wt [current_project]
set_property parent.project_path C:/Users/hejsh/Desktop/singleCPU/singleCPU.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/hejsh/Desktop/singleCPU/singleCPU.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files c:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/ip/iCache/iCache.coe
add_files c:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/ip/dCache/dCache.coe
read_verilog -library xil_defaultlib {
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/ALU.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/CLA.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/ControlUnit.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/IR.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/RegFile.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/SUB.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/add_32.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/and_2.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/extend.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/leftShift_2.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/mux2.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/mux2_6.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/pc.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/pcadd_4.v
  C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/new/toplevel.v
}
read_ip -quiet C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/ip/dCache/dCache.xci
set_property used_in_implementation false [get_files -all c:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/ip/dCache/dCache_ooc.xdc]

read_ip -quiet C:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/ip/iCache/iCache.xci
set_property used_in_implementation false [get_files -all c:/Users/hejsh/Desktop/singleCPU/singleCPU.srcs/sources_1/ip/iCache/iCache_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top toplevel -part xc7k70tfbv676-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef toplevel.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file toplevel_utilization_synth.rpt -pb toplevel_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
