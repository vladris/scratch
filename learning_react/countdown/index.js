import * as React from 'react'
import ReactDOM from 'react-dom'
import { Dispatcher } from 'flux'
import { EventEmitter } from 'events'

const Countdown = ({count, tick, reset}) => {
    if (count) {
        setTimeout(() => tick(), 1000)
    }

    return (count) ?
        <h1>{count}</h1> :
        <div onClick={() => reset(10)}>
            <span>CELEBRATE!</span>
            <span>(click to start over)</span>
        </div>
}

const countdownActions = dispatcher =>
    ({
        tick(currentCount) {
            dispatcher.handleAction({ type: 'TICK' })
        },
        reset(count) {
            dispatcher.handleAction({ type: 'RESET', count })
        }
    })

class CountdownDispatcher extends Dispatcher {
    handleAction(action) {
        console.log('dispatching action:', action)
        this.dispatch({ source: 'VIEW_ACTION', action })
    }
}

class CountdownStore extends EventEmitter {
    constructor(count=5, dispatcher) {
        super()
        this._count = count
        this.dispatcherIndex = dispatcher.register(
            this.dispatch.bind(this)
        )
    }

    get count() {
        return this._count
    }

    dispatch(payload) {
        const { type, count } = payload.action
        switch (type) {
            case 'TICK':
                this._count -= 1
                this.emit('TICK', this._count)
                return true
            case 'RESET':
                this._count = count
                this.emit('RESET', this._count)
                return true
        }
    }
}

const appDispatcher = new CountdownDispatcher()
const actions = countdownActions(appDispatcher)
const store = new CountdownStore(10, appDispatcher)

const render = count => ReactDOM.render(
    <Countdown count={count} {...actions} />,
    document.getElementById('react-container')
)

store.on('TICK', () => render(store.count))
store.on('RESET', () => render(store.count))
render(store.count)
