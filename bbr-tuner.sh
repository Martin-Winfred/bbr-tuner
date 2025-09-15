#!/usr/bin/env bash
# Interactive BBR Congestion Control Configuration Script with Best Practices

set -e

# Global language variable
LANGUAGE="zh"  # Default to Chinese

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Language strings
declare -A STRINGS

# English strings
STRINGS["en_title"]="BBR Congestion Control Configuration Tool"
STRINGS["en_current_status"]="Current System Status"
STRINGS["en_available_cc"]="Available Congestion Control Algorithms"
STRINGS["en_current_cc"]="Current Congestion Control Algorithm"
STRINGS["en_current_qdisc"]="Current Queue Scheduler"
STRINGS["en_bbr_status"]="BBR Module Status"
STRINGS["en_loaded"]="Loaded"
STRINGS["en_not_loaded"]="Not Loaded"
STRINGS["en_menu_options"]="Select Operation"
STRINGS["en_menu_1"]="Check and Load BBR Module"
STRINGS["en_menu_2"]="Set Congestion Control Algorithm"
STRINGS["en_menu_3"]="Set Queue Scheduler"
STRINGS["en_menu_4"]="Quick Enable BBR (Recommended)"
STRINGS["en_menu_5"]="Show Current Status"
STRINGS["en_menu_6"]="Save Configuration Permanently"
STRINGS["en_menu_7"]="Switch Language"
STRINGS["en_menu_0"]="Exit"
STRINGS["en_prompt_choice"]="Please select an option"
STRINGS["en_default"]="Default"
STRINGS["en_confirm"]="Confirm"
STRINGS["en_yes"]="yes"
STRINGS["en_no"]="no"
STRINGS["en_info_checking_bbr"]="Checking BBR module..."
STRINGS["en_success_bbr_available"]="BBR module is available"
STRINGS["en_warning_bbr_not_found"]="BBR module not detected"
STRINGS["en_ask_load_bbr"]="Do you want to try loading the BBR module?"
STRINGS["en_success_bbr_loaded"]="Successfully loaded tcp_bbr module"
STRINGS["en_error_bbr_load"]="Failed to load tcp_bbr module, kernel may not support it"
STRINGS["en_error_bbr_not_in_list"]="Module loaded but not in available algorithms list"
STRINGS["en_select_cc"]="Select Congestion Control Algorithm"
STRINGS["en_select_qdisc"]="Select Queue Scheduler"
STRINGS["en_common_qdisc"]="Common Queue Schedulers"
STRINGS["en_qdisc_fq"]="fq - Fair Queue ★ Best match for BBR"
STRINGS["en_qdisc_fq_codel"]="fq_codel - Fair Queue with CoDel"
STRINGS["en_qdisc_cake"]="cake - Common Applications Kept Enhanced"
STRINGS["en_qdisc_pie"]="pie - Proportional Integral controller Enhanced"
STRINGS["en_qdisc_bfifo"]="bfifo - Byte FIFO"
STRINGS["en_qdisc_pfifo"]="pfifo - Packet FIFO"
STRINGS["en_qdisc_pfifo_fast"]="pfifo_fast - Default Linux scheduler"
STRINGS["en_qdisc_ecn"]="ecn - Explicit Congestion Notification"
STRINGS["en_qdisc_best_batch"]="★ Best match for batch processing"
STRINGS["en_qdisc_best_bbr"]="★ Best match for BBR"
STRINGS["en_ask_permanent"]="Do you want to save configuration permanently to"
STRINGS["en_success_saved"]="Configuration saved to"
STRINGS["en_backup_file"]="Backup file"
STRINGS["en_quick_enable"]="Starting quick BBR enable..."
STRINGS["en_success_bbr_enabled"]="BBR successfully enabled!"
STRINGS["en_bbr_unavailable"]="BBR module unavailable, trying other algorithms..."
STRINGS["en_invalid_option"]="Invalid option"
STRINGS["en_press_enter"]="Press Enter to continue..."
STRINGS["en_exit"]="Exiting script"
STRINGS["en_root_required"]="This script requires root privileges"
STRINGS["en_algorithm_not_available"]="Algorithm not in available list"
STRINGS["en_setting_cc"]="Setting congestion control algorithm to"
STRINGS["en_setting_qdisc"]="Setting queue scheduler to"
STRINGS["en_success_set"]="Successfully set"
STRINGS["en_error_set"]="Failed to set"
STRINGS["en_language_switched"]="Language switched to"
STRINGS["en_enter_cc_algorithm"]="Enter congestion control algorithm"
STRINGS["en_enter_qdisc"]="Enter queue scheduler"
STRINGS["en_please_enter_y_or_n"]="Please enter y or n"
STRINGS["en_info"]="Info"
STRINGS["en_success"]="Success"
STRINGS["en_warning"]="Warning"
STRINGS["en_error"]="Error"
STRINGS["en_header"]="Header"
STRINGS["en_recommended"]="Recommended"
STRINGS["en_current"]="Current"

# Chinese strings
STRINGS["zh_title"]="BBR 拥塞控制配置工具"
STRINGS["zh_current_status"]="当前系统状态"
STRINGS["zh_available_cc"]="可用拥塞控制算法"
STRINGS["zh_current_cc"]="当前拥塞控制算法"
STRINGS["zh_current_qdisc"]="当前队列调度器"
STRINGS["zh_bbr_status"]="BBR 模块状态"
STRINGS["zh_loaded"]="已加载"
STRINGS["zh_not_loaded"]="未加载"
STRINGS["zh_menu_options"]="请选择操作"
STRINGS["zh_menu_1"]="检查并加载 BBR 模块"
STRINGS["zh_menu_2"]="设置拥塞控制算法"
STRINGS["zh_menu_3"]="设置队列调度器"
STRINGS["zh_menu_4"]="快速启用 BBR (推荐)"
STRINGS["zh_menu_5"]="显示当前状态"
STRINGS["zh_menu_6"]="永久保存配置"
STRINGS["zh_menu_7"]="切换语言"
STRINGS["zh_menu_0"]="退出"
STRINGS["zh_prompt_choice"]="请输入选项"
STRINGS["zh_default"]="默认"
STRINGS["zh_confirm"]="确认"
STRINGS["zh_yes"]="是"
STRINGS["zh_no"]="否"
STRINGS["zh_info_checking_bbr"]="检查 BBR 模块..."
STRINGS["zh_success_bbr_available"]="BBR 模块已可用"
STRINGS["zh_warning_bbr_not_found"]="未检测到 BBR 模块"
STRINGS["zh_ask_load_bbr"]="是否尝试加载 BBR 模块?"
STRINGS["zh_success_bbr_loaded"]="成功加载 tcp_bbr 模块"
STRINGS["zh_error_bbr_load"]="无法加载 tcp_bbr 模块，可能内核未编译支持"
STRINGS["zh_error_bbr_not_in_list"]="模块加载成功但仍未在可用算法列表中"
STRINGS["zh_select_cc"]="选择拥塞控制算法"
STRINGS["zh_select_qdisc"]="选择队列调度器"
STRINGS["zh_common_qdisc"]="常见队列调度器"
STRINGS["zh_qdisc_fq"]="fq - 公平队列 ★ 与 BBR 最佳匹配"
STRINGS["zh_qdisc_fq_codel"]="fq_codel - 带 CoDel 的公平队列"
STRINGS["zh_qdisc_cake"]="cake - 通用应用保持增强"
STRINGS["zh_qdisc_pie"]="pie - 比例积分控制器增强版"
STRINGS["zh_qdisc_bfifo"]="bfifo - 字节先进先出"
STRINGS["zh_qdisc_pfifo"]="pfifo - 数据包先进先出"
STRINGS["zh_qdisc_pfifo_fast"]="pfifo_fast - Linux 默认调度器"
STRINGS["zh_qdisc_ecn"]="ecn - 显式拥塞通知"
STRINGS["zh_qdisc_best_batch"]="★ 最适合批量处理"
STRINGS["zh_qdisc_best_bbr"]="★ 最适合 BBR"
STRINGS["zh_ask_permanent"]="是否将配置永久保存到"
STRINGS["zh_success_saved"]="配置已保存到"
STRINGS["zh_backup_file"]="备份文件"
STRINGS["zh_quick_enable"]="开始快速启用 BBR..."
STRINGS["zh_success_bbr_enabled"]="BBR 已成功启用！"
STRINGS["zh_bbr_unavailable"]="BBR 模块不可用，尝试设置其他算法..."
STRINGS["zh_invalid_option"]="无效选项"
STRINGS["zh_press_enter"]="按回车键继续..."
STRINGS["zh_exit"]="退出脚本"
STRINGS["zh_root_required"]="此脚本需要 root 权限运行"
STRINGS["zh_algorithm_not_available"]="算法不在可用列表中"
STRINGS["zh_setting_cc"]="将拥塞控制算法设置为"
STRINGS["zh_setting_qdisc"]="将队列调度器设置为"
STRINGS["zh_success_set"]="成功将"
STRINGS["zh_error_set"]="设置失败"
STRINGS["zh_language_switched"]="语言已切换为"
STRINGS["zh_enter_cc_algorithm"]="请输入拥塞控制算法"
STRINGS["zh_enter_qdisc"]="请输入队列调度器"
STRINGS["zh_please_enter_y_or_n"]="请输入 y 或 n"
STRINGS["zh_info"]="信息"
STRINGS["zh_success"]="成功"
STRINGS["zh_warning"]="警告"
STRINGS["zh_error"]="错误"
STRINGS["zh_header"]="标题"
STRINGS["zh_recommended"]="推荐"
STRINGS["zh_current"]="当前"

# Get localized string
get_str() {
    local key="$1"
    local lang_key="${LANGUAGE}_${key}"
    
    if [[ -n "${STRINGS[$lang_key]}" ]]; then
        echo "${STRINGS[$lang_key]}"
    else
        # Fallback to English if translation not available
        local en_key="en_${key}"
        echo "${STRINGS[$en_key]:-$key}"
    fi
}

# Print colored information
print_info() {
    echo -e "${BLUE}[$(get_str info)]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[$(get_str success)]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[$(get_str warning)]${NC} $1"
}

print_error() {
    echo -e "${RED}[$(get_str error)]${NC} $1"
}

print_header() {
    echo -e "${PURPLE}[$(get_str header)]${NC} $1"
}

print_highlight() {
    echo -e "${CYAN}$1${NC}"
}

# Check if running as root
check_root() {
    if [[ $EUID -ne 0 ]]; then
        print_error "$(get_str root_required)"
        exit 1
    fi
}

# Get user input with default value
get_user_choice() {
    local prompt="$1"
    local default="$2"
    local choice
    
    while true; do
        if [[ -n "$default" ]]; then
            read -p "$prompt [$(get_str default): $default]: " choice
            choice=${choice:-$default}
        else
            read -p "$prompt: " choice
        fi
        
        echo "$choice"
        return
    done
}

# Confirmation function
confirm_action() {
    local prompt="$1"
    local choice
    
    while true; do
        read -p "$prompt ($(get_str yes)/$(get_str no)): " choice
        case "$choice" in
            y|Y|yes|YES|Yes|是|YES)
                return 0
                ;;
            n|N|no|NO|No|否|NO)
                return 1
                ;;
            *)
                print_warning "$(get_str please_enter_y_or_n)"
                ;;
        esac
    done
}

# Show current system status
show_current_status() {
    echo "=== $(get_str current_status) ==="
    echo "$(get_str current_cc): $(sysctl -n net.ipv4.tcp_congestion_control)"
    echo "$(get_str available_cc): $(sysctl -n net.ipv4.tcp_available_congestion_control)"
    echo "$(get_str current_qdisc): $(sysctl -n net.core.default_qdisc)"
    echo "$(get_str bbr_status): $(lsmod | grep -q tcp_bbr && echo "$(get_str loaded)" || echo "$(get_str not_loaded)")"
    echo
}

# Check and load BBR module
setup_bbr_module() {
    print_info "$(get_str info_checking_bbr)"
    
    local available_cc=$(sysctl -n net.ipv4.tcp_available_congestion_control)
    
    if echo "$available_cc" | grep -qw bbr; then
        print_success "$(get_str success_bbr_available)"
        return 0
    fi
    
    print_warning "$(get_str warning_bbr_not_found)"
    
    if confirm_action "$(get_str ask_load_bbr)"; then
        if modprobe tcp_bbr 2>/dev/null; then
            print_success "$(get_str success_bbr_loaded)"
            
            # Recheck
            available_cc=$(sysctl -n net.ipv4.tcp_available_congestion_control)
            if echo "$available_cc" | grep -qw bbr; then
                print_success "$(get_str success_bbr_available)"
                return 0
            else
                print_error "$(get_str error_bbr_not_in_list)"
                return 1
            fi
        else
            print_error "$(get_str error_bbr_load)"
            return 1
        fi
    fi
    
    return 1
}

# Set congestion control algorithm
set_congestion_control() {
    local target_algo="$1"
    
    if [[ -z "$target_algo" ]]; then
        # Get user selection
        echo "=== $(get_str select_cc) ==="
        local available_cc=$(sysctl -n net.ipv4.tcp_available_congestion_control)
        echo "$(get_str available_cc): $available_cc"
        
        local current_cc=$(sysctl -n net.ipv4.tcp_congestion_control)
        echo "$(get_str current): $current_cc"
        
        # Highlight BBR if available
        if echo "$available_cc" | grep -qw bbr; then
            print_highlight "★ BBR - Google's Bottleneck Bandwidth and Round-trip propagation time"
        fi
        
        target_algo=$(get_user_choice "$(get_str enter_cc_algorithm)" "$current_cc")
    fi
    
    # Validate algorithm availability
    local available_cc=$(sysctl -n net.ipv4.tcp_available_congestion_control)
    if ! echo "$available_cc" | grep -qw "$target_algo"; then
        print_error "$(get_str algorithm_not_available): $target_algo"
        echo "$(get_str available_cc): $available_cc"
        return 1
    fi
    
    if confirm_action "$(get_str confirm) $(get_str setting_cc) $target_algo?"; then
        if sysctl -w net.ipv4.tcp_congestion_control="$target_algo" >/dev/null 2>&1; then
            print_success "$(get_str success_set) $(get_str setting_cc) $target_algo"
            return 0
        else
            print_error "$(get_str error_set) $(get_str setting_cc)"
            return 1
        fi
    fi
    
    return 1
}

# Set queue scheduler
set_qdisc() {
    local target_qdisc="$1"
    
    if [[ -z "$target_qdisc" ]]; then
        # Get user selection
        echo "=== $(get_str select_qdisc) ==="
        local current_qdisc=$(sysctl -n net.core.default_qdisc)
        echo "$(get_str current): $current_qdisc"
        
        echo "$(get_str common_qdisc):"
        print_highlight "  fq        - $(get_str qdisc_fq)"
        echo "  fq_codel  - $(get_str qdisc_fq_codel)"
        echo "  cake      - $(get_str qdisc_cake)"
        echo "  pie       - $(get_str qdisc_pie)"
        print_highlight "  pfifo_fast - $(get_str qdisc_pfifo_fast) $(get_str qdisc_best_batch)"
        echo "  bfifo     - $(get_str qdisc_bfifo)"
        echo "  pfifo     - $(get_str qdisc_pfifo)"
        echo "  ecn       - $(get_str qdisc_ecn)"
        
        echo
        print_highlight "★ $(get_str recommended): fq (for BBR), pfifo_fast (for batch processing)"
        
        target_qdisc=$(get_user_choice "$(get_str enter_qdisc)" "$current_qdisc")
    fi
    
    if confirm_action "$(get_str confirm) $(get_str setting_qdisc) $target_qdisc?"; then
        if sysctl -w net.core.default_qdisc="$target_qdisc" >/dev/null 2>&1; then
            print_success "$(get_str success_set) $(get_str setting_qdisc) $target_qdisc"
            return 0
        else
            print_error "$(get_str error_set) $(get_str setting_qdisc)"
            return 1
        fi
    fi
    
    return 1
}

# Save configuration permanently
make_permanent() {
    local config_file="/etc/sysctl.conf"
    
    if [[ ! -f "$config_file" ]]; then
        config_file="/etc/sysctl.d/99-bbr.conf"
        touch "$config_file"
    fi
    
    if confirm_action "$(get_str ask_permanent) $config_file?"; then
        local current_cc=$(sysctl -n net.ipv4.tcp_congestion_control)
        local current_qdisc=$(sysctl -n net.core.default_qdisc)
        
        # Backup original file
        cp "$config_file" "${config_file}.bak.$(date +%Y%m%d_%H%M%S)" 2>/dev/null || true
        
        # Remove old configuration lines
        grep -v "^net.ipv4.tcp_congestion_control" "$config_file" > "${config_file}.tmp" 2>/dev/null || true
        mv "${config_file}.tmp" "$config_file" 2>/dev/null || true
        
        grep -v "^net.core.default_qdisc" "$config_file" > "${config_file}.tmp" 2>/dev/null || true
        mv "${config_file}.tmp" "$config_file" 2>/dev/null || true
        
        # Add new configuration
        echo "# BBR Configuration" >> "$config_file"
        echo "net.ipv4.tcp_congestion_control = $current_cc" >> "$config_file"
        echo "net.core.default_qdisc = $current_qdisc" >> "$config_file"
        
        print_success "$(get_str success_saved) $config_file"
        print_info "$(get_str backup_file): ${config_file}.bak.*"
        return 0
    fi
    
    return 1
}

# Switch language
switch_language() {
    echo "=== Language / 语言 ==="
    echo "1) English"
    echo "2) 中文"
    echo "3) Auto detect / 自动检测"
    
    local choice=$(get_user_choice "$(get_str prompt_choice)" "3")
    
    case "$choice" in
        1|en|english|English)
            LANGUAGE="en"
            print_success "Language switched to English"
            ;;
        2|zh|chinese|Chinese|中文)
            LANGUAGE="zh"
            print_success "语言已切换为中文"
            ;;
        3|auto|Auto|自动|自动检测)
            # Detect system language
            if [[ "$LANG" =~ ^zh ]]; then
                LANGUAGE="zh"
                print_success "语言已切换为中文"
            else
                LANGUAGE="en"
                print_success "Language switched to English"
            fi
            ;;
        *)
            print_warning "$(get_str invalid_option): $choice"
            ;;
    esac
}

# Quick enable BBR
quick_enable_bbr() {
    print_info "$(get_str quick_enable)"
    
    # 1. Load BBR module
    if setup_bbr_module; then
        # 2. Set congestion control algorithm to BBR
        if set_congestion_control "bbr"; then
            # 3. Set queue scheduler to fq
            if set_qdisc "fq"; then
                print_success "$(get_str success_bbr_enabled)"
                echo
                show_current_status
                return 0
            fi
        fi
    else
        print_warning "$(get_str bbr_unavailable)"
        set_congestion_control
        set_qdisc
    fi
    
    return 1
}

# Show menu
show_menu() {
    clear
    echo "=========================================="
    echo "         $(get_str title)"
    echo "=========================================="
    show_current_status
    echo "$(get_str menu_options):"
    echo "  1) $(get_str menu_1)"
    echo "  2) $(get_str menu_2)"
    echo "  3) $(get_str menu_3)"
    echo "  4) $(get_str menu_4)"
    echo "  5) $(get_str menu_5)"
    echo "  6) $(get_str menu_6)"
    echo "  7) $(get_str menu_7)"
    echo "  0) $(get_str menu_0)"
    echo "=========================================="
}

# Main function
main() {
    check_root
    
    # Auto-detect language on first run
    if [[ "$LANG" =~ ^zh ]]; then
        LANGUAGE="zh"
    else
        LANGUAGE="en"
    fi
    
    while true; do
        show_menu
        local choice=$(get_user_choice "$(get_str prompt_choice)" "0")
        
        case "$choice" in
            1)
                setup_bbr_module
                read -p "$(get_str press_enter)" 
                ;;
            2)
                set_congestion_control
                read -p "$(get_str press_enter)" 
                ;;
            3)
                set_qdisc
                read -p "$(get_str press_enter)" 
                ;;
            4)
                quick_enable_bbr
                read -p "$(get_str press_enter)" 
                ;;
            5)
                show_current_status
                read -p "$(get_str press_enter)" 
                ;;
            6)
                make_permanent
                read -p "$(get_str press_enter)" 
                ;;
            7)
                switch_language
                read -p "$(get_str press_enter)" 
                ;;
            0)
                print_info "$(get_str exit)"
                exit 0
                ;;
            *)
                print_warning "$(get_str invalid_option): $choice"
                read -p "$(get_str press_enter)" 
                ;;
        esac
    done
}

# Run main function
main "$@"