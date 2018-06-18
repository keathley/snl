use "random"
use "collections"
use "promises"
use "time"
use "itertools"

class val Summary
  let moves: Array[U64] val
  let turns: U64

  new val create(turns': U64, moves': Array[U64] val) =>
    turns = turns'
    /* moves = consume moves' */
    moves = consume moves'

actor Game
  let _dice: Dice
  let _env: Env
  var _position: U64 = 0
  var _turns: U64 = 0

  new create(env: Env) =>
    _env = env
    _dice = Dice(Rand(Time.nanos(), Time.nanos()))

  be play(p: Promise[Summary]) =>
    let moves: Array[U64] = []

    while finished() == false do
      let spaces = _roll()
      moves.push(spaces)
      move(_roll())
    end

    p(recover Summary(_turns, moves) end)

  fun ref _roll(): U64 => _dice(1, 6)

  fun finished(): Bool => _position > 100

  fun ref move(spaces: U64) =>
    _turns = if spaces == 6 then _turns else _turns + 1 end
    _position = _position + spaces
    _position = _teleport(_position)

  fun _teleport(position: U64): U64 => match position
    | 1 => 38
    | 4 => 14
    | 9 => 31
    | 16 => 6
    | 21 => 42
    | 28 => 84
    | 36 => 44
    | 47 => 26
    | 49 => 11
    | 51 => 67
    | 56 => 53
    | 62 => 19
    | 64 => 60
    | 71 => 91
    | 80 => 100
    | 87 => 24
    | 93 => 73
    | 95 => 75
    | 98 => 78
    else
      position
    end


actor Main
  let _env: Env

  new create(env: Env) =>
    _env = env

    env.out.print("Simulating...")

    let games = Iter[U64](Range[U64](0, 100_000))

    let play_game = {(i: U64): Promise[Summary] =>
      let p = Promise[Summary]
      Game(env).>play(p)
      p
    } iso

    Promises[Summary]
      .join(games.map[Promise[Summary]](consume play_game))
      .next[None](recover this~summarize() end)

  be summarize(turns: Array[Summary] val) =>
    _env.out.print("We're done")
    /* _env.out.print("Max Turns: " + max(turns).string()) */
    /* _env.out.print("Min Turns: " + min(turns).string()) */

  fun max(turns: Array[U64] val): U64 =>
    Iter[U64](turns.values())
      .fold[U64](0, {(largest, next) => if largest >= next then largest else next end})

  fun min(turns: Array[U64] val): U64 =>
    Iter[U64](turns.values())
      .fold[U64](U64.max_value(), {(smallest, next) => if smallest <= next then smallest else next end})
