#!/usr/bin/bash

function list_DB_functions(){
    : 'select i in "List tables" "Create tables" "Drop tables" "Insert tables" "Select from table" "Update table" "Delete from table"
    do 
    done '
    echo "Create tables"
}

echo "Please choose from the menu below"
select order in CreateDB ConnectDB ListDB DropDB
do 
    case $order in 
        CreateDB ) 
        while true
        do
            read -p "Enter Name of DB : " name
            
            if [[ $name == +([a-zA-Z]) ]] ; then 
                if [ -e $name ];then 
                    echo "already existed"
                    continue
                else
                    echo "correct name"
                    mkdir ~/Documents/Bash/project/DBMS/$name
                    break
                fi 
            else
                echo "error in naming database please, re-enter a proper name" 

            fi
        done
        ;;
        ConnectDB )
                while true
                do
                read -p "Enter Name of DB " name 
                if [[ $name == +([a-zA-Z]) ]]; then
                    if [ -d $name ] ; then 
                        cd ~/Documents/Bash/project/DBMS/$name
                        echo "you're at " `pwd`
                        list_DB_functions
                        break
                    
                    else 
                        echo "Sorry it's not existed please, check if this database is existed  "
                        break
                    fi

                else
                        echo " error in database name please, re-enter it"
                        continue
                fi
                done
        ;;
        ListDB ) 
            ls -F | grep "/"
        ;;
        DropDB )
        ;;
    esac
done




