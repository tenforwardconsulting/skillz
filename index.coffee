class window.Skillz
  skillz: []
  constructor: (options) ->
    $(document).ready @initialize

  initialize: => 
    @$el = $('.canvas')
    if localStorage.key('skillz')
      @skillz = JSON.parse(localStorage.getItem('skillz'))
      @renderSkillz()
    
    $.getJSON 'skillz.json', null, (result) =>
      for skill in result
        if !@getSkill(skill.id)
          @skillz.push(skill)
      @renderSkillz()  
      

    $(window).resize @onResize

  renderSkillz: =>
    $('ul').empty()
    for skill in @skillz
      $('ul').append("<li data-skill-id='#{skill.id}' class='#{skill.category}'>#{skill.name}</li>")

    $('li').draggable
      stop: @onDragStop
    @onResize()
    
  onDragStop: (ev) => 
    x = (ev.pageX - ev.offsetX) / $(window).width()
    y = (ev.pageY - ev.offsetY)/ $(window).height()
    target = $(ev.target)
    skill = @getSkill target.data('skill-id')
    skill.x = x
    skill.y = y
    console.log("#{x},#{y} - #{target.css('top')}")
    @save()

  onResize: (ev) =>
    for skill in @skillz
      if skill.x
        console.log("#{skill.x},#{skill.y} - #{$(window).width()}")
        console.log("moving to #{skill.x * $(window).width()}, #{skill.y * $(window).height()}")
        $("[data-skill-id=#{skill.id}]").css
          top: skill.y * $(window).height()
          left: skill.x * $(window).width()

  save: ->
    localStorage.setItem('skillz', JSON.stringify(@skillz))

  getSkill: (id) -> 
    for skill in @skillz
      return skill if skill.id == id






