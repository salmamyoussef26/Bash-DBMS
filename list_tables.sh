
function main(){
    echo "your database $name contains tables:"
    find $table_name  | grep -v "metadata"
}
main
list_DBConnection_functions
