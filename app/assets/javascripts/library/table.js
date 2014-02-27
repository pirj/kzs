// TODO: @tagir need refactor. This code must have a default modificator value instead of two modificators.
/**
* Created by shine on 28.01.14.
*/
$(document).ready(function(){

        var actions = {
            append: function(elem, target){
                target.toggle();
                elem.addClass('tr-slim')
            },
            replace: function(elem, target, visible){
                console.log('show!');
                elem.toggle();
             //   visible.show()
                target.toggle();
            },
            close: function(table){
                console.log(table.find('.js-more-info'))
                table.find('tr').show();
                table.find('.js-more-info').hide();
                table.find('tr.tr-slim').removeClass('tr-slim');
            }
        }

        $(document).on('click', '.js-row-clickable tr a, .js-row-clickable tr input', function(e) {
            e.stopPropagation();

            // return false;
        })


        $(document).on('click', '.js-row-clickable tr', function(e) {

            console.log('click!')
            var $elem, $target, id;
            e.preventDefault();
            $elem = $(this).find($('.js-info'));

            $thisTable = $((this.parentNode).parentNode);
            $visible = $(this).find('.js-visible');

            id = $(this).data('id');
            $target =  $(this).find(".js-more-info");
           // console.log( $target )
//            if (!$elem.hasClass('js-more-info')) {actions.close($thisTable);}

            if ((id != null) && $target.length > 0) {               //существует ссылка и связанный обьект
                _.each((this.parentNode).parentNode.classList, function(a){

                    switch (a) {

                        case 'm-table-append':

                            actions.append($elem, $target);
                            break

                        default:
                            actions.replace($elem, $target, $visible);

                    }
                })
            }
        });
});
