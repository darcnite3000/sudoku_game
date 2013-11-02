$ ->
  window.sudoku_game = null
  init = ->
    window.sudoku_game = new SudokuHandler()
  $(window).on 'page:load', init
  init()

class @SudokuHandler
  constructor: (board_elem = '#board')->
    @board = $(board_elem)
    @board.on 'click', '.controls .reset', (event)=>
      event.preventDefault()
      @board.find('.cell').filter((elem)->!$(this).hasClass('locked')).text('')
    @board.on 'click', '.available .value', (event)=>
      event.preventDefault()
      value = $(event.target)
      unless value.hasClass('unavailable')
        @board
          .find('.cell.highlight')
          .text(value.text())
    @board.on 'click', '.cell', (event)=>
      event.preventDefault()
      cell = $(event.target)
      unless cell.hasClass('locked')
        @board.find('.cell.highlight').removeClass('highlight')
        cell.addClass('highlight')
        @getAvailableValuesForCell cell.data('col'), cell.data('row'), (data)=>
          console.log data
          @board.find('.available .value')
            .addClass('unavailable')
            .filter(->
              $.inArray(parseInt($(this).data('val')), data) >= 0
            ).removeClass('unavailable')
  getCellList: ->
    cells = []
    @board.find('.cell').each (i, elem)->
      val = $(elem).text()
      cellvalue = parseInt(if val=="" then 0 else val)
      cells.push(cellvalue)
    cells
  getAvailableValuesForCell: (x,y,callback = (data)-> )->
    $.ajax
      type: 'post'
      url: '/sudoku/values.json'
      dataType: 'json'
      data:
        cells: @getCellList()
        cell: [x, y]
      success: callback