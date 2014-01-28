/**
 * Created by shine on 28.01.14.
 */
$(document).ready(function(){

        var actions = {
            open: function(){},
            close: function(table){
                table.find('tr').show();
                table.find('.js-more-info').hide();

            }
        }

        $(document).on('click', '.js-row-clickable tr', function(e) {

        //    console.log('tr');
            var $elem, $target, id;
            e.preventDefault();
            $elem = $(this);

            $thisTable = $((this.parentNode).parentNode);







            id = $elem.data('id');
            $target = $elem.siblings(".js-more-info[data-id=" + id + "]");






            if (!$elem.hasClass('js-more-info')) {actions.close($thisTable);}

            if ((id != null) && $target.length > 0) {               //существует ссылка и связанный обьект

                _.each((this.parentNode).parentNode.classList, function(a){



                    switch (a) {

                        case 'm-table-append':

                           $target.toggle();
                        break

                        case 'm-table-replacement':
                            $elem.toggle();
                            $target.toggle();
                        break

                    }
                })


            }






        });
});
