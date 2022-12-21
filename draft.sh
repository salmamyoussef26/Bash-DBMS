# #!/bin/bash

# # read -p "enter an input " input
# # if [[ $input == +([a-zA-Z0-9_-]) ]] && [[ $input == [a-zA-Z]* ]];then
# #     echo "valid"
# # else
# #     echo "not valid"
# # fi
# #--------------------------
# declare -A dictionary
# declare -a columns_name
# declare -a data_taypes
# # animals['key']='value' to set value

# # "${animals[@]}" to expand the values

# # "${!animals[@]}" (notice the !) to expand the keys
# read -p "enter number of columns" columns_num
# for ((i=0; i<columns_num; i++))
# do
#     read columns_name[$i]
# done

# for ((i=0; i<columns_num; i++))
# do
#     read data_taypes[$i]
# done

# # key_var='key3'
# # value_var='value3'
# # test_dict[$key_var]=$value_var

# for((i=0; i<columns_num; i++))
# do
#     dictionary[${columns_name[$i]}]=${data_taypes[$i]} 
# done

# # for key in "${!test_dict[@]}"; do
# #     echo "$key ${test_dict[$key]}"
# # done
# for key in "${!dictionary[@]}"
# do
#     echo $key ":" ${dictionary[$key]}
# done

