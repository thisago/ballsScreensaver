import script/ball

import std/dom

when isMainModule:
  let
    container = document.querySelector "div.bg"

  var
    balls: seq[Ball] = @[]

  for i in 0..<20:
    discard window.setTimeout(proc () =
      var
        ball = ball.initBall()

      balls.add ball;

      container.appendChild(ball.element)
      ball.update();
    , i * 200)

  discard setInterval(window, proc () =
    for ball in balls.mitems:
      ball.update();

      if ball.needReplace:
        ball.element.remove()
        ball = initBall()
        container.appendChild(ball.element)
  , 150)
