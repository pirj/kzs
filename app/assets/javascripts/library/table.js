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
            replace: function(elem, target){
                elem.toggle();
                target.toggle();
            },
            close: function(table){
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

                            actions.append($elem, $target);
                        break

                        case 'm-table-replacement':
                            actions.replace($elem, $target);
                        break
                    }
                })
            }
        });
});
