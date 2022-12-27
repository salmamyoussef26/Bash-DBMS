
function main(){
read -p "Enter table name to delete " table_name 
if [[ $table_name == +([a-zA-Z0-9_-]) ]] && [[ $table_name == [a-zA-Z]* ]];then
    if [ -e $table_name ] ; then 
        
        echo "correct name and the table $table_name has been removed"
        rm -f $table_name "$table_name metadata"
        break
    
    else 
        echo "Sorry this table's not existed "3
        break
    fi
    
else
        echo " Error in the table name "
fi
}

main
