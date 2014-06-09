`/** @jsx React.DOM */`


###

Компонент создан для создания слайдшоу по функционалу будущих модулей

На входе передаем набор урлов на изображение, не важно где они хранятся
Можно передавать через image_path(path_to_image)

При клике он переключает картинки по кругу, не важно сколько изображений

Последовательность изображений задается последовательностью в массиве урлов

###



R = React.DOM

@MockModuleSlides = React.createClass


  getDefaultProps: ->
    img_urls: []

  getInitialState: ->
    num: 1

  handleClick: ->
    new_num = @.state.num + 1
    new_num = 1 if new_num > @.props.img_urls.length
    @.setState num: new_num


  render: ->
    # рисуем одно изображение
    render_img = (path, num) =>
      className = ['_mock-module-img']
      if num == @.state.num
        className.push('m-visible')
      else
        className.push('m-hidden')

      R.img({src: path, className: className.join(' '), onClick: @.handleClick})

    R.div({className: 'row'},
      R.div({className: 'col-sm-12'},
        @.props.img_urls.map( (img_path, i) ->
          this_num = i+1
          render_img(img_path, this_num)
        )
      )
    )
