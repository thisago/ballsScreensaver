import std/[random, dom, colors]

type
  Coordinates* = tuple
    ## X and Y coordinates
    x, y: float
  Ball* = object
    ## The ball object, with all properties
    pos, speed*: Coordinates
    size*: int
    color*: cstring
    element*: Element
    needReplace*: bool


proc initBall*(): Ball =
  ## generate a new random ball
  random.randomize()
  let
    element = document.createElement "span"
    color = rgb(
      r = random.rand(0..255),
      g = random.rand(0..255),
      b = random.rand(0..255)
    )
    pos = (
      # x: random.rand(-20.0..100.0),
        # y: random.rand(-20.0..100.0)
      x: random.rand(-20.0..120.0),
      y: random.rand(-20.0..120.0)
    )
    speed = (
      x: random.rand(-50.0..50.0),
      y: random.rand(-50.0..50.0)
    )
    size = random.rand(1..20)

  element.className = "ball shadow"

  return Ball(
    color: cstring $color,
    pos: pos,
    speed: speed,
    size: size,
    element: element,
    needReplace: false
  )

proc configElement*(self: var Ball) =
  self.element.style.setProperty("--color", self.color)
  self.element.style.setProperty("--size", $self.size & "em")
  self.element.style.setProperty("--x", $self.pos.x & "%")
  self.element.style.setProperty("--y", $self.pos.y & "%")


func update*(self: var Ball) =
  ## Updates the ball
  self.pos.x += self.speed.x / 100
  self.pos.y += self.speed.y / 100

  let
    limit = (
      min: (
        x: (float self.size * -2) / 0.5,
        y: (float self.size * -2) / 0.5
      ),
      max: (
        x: 100.0 + float self.size,
        y: 100.0 + float self.size
      )
    )

  if
    self.pos.x < limit.min.x or
    self.pos.y < limit.min.y or
    self.pos.x > limit.max.x or
    self.pos.y > limit.max.y:
      self.needReplace = true

  self.configElement()
