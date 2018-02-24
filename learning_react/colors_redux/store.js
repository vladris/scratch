import { createStore, combineReducers, applyMiddleware } from 'redux'
import { colors, sort } from './reducers'

const initialState = {
    colors: [
        {
            id: "3315e1p5-3abl-0p523-30e4-8001l8yf3036",
            title: "Rad Red",
            color: "#FF0000",
            rating: 3,
            timestamp: "Sat Mar 12 2016 16:12:09 GMT-0800 (PST)"
        },
        {
            id: "3315e1p5-3abl-0p523-30e4-8001l8yf4457",
            title: "Crazy Green",
            color: "#00FF00",
            rating: 0,
            timestamp: "Fri Mar 11 2016 12:00:00 GMT-0800 (PST)"
        },
        {
            id: "3315e1p5-3abl-0p523-30e4-8001l8yf2412",
            title: "Big Blue",
            color: "#0000FF",
            rating: 5,
            timestamp: "Thu Mar 10 2016 01:11:12 GMT-0800 (PST)"
        }
    ],
    sort: "SORTED_BY_TITLE"
}

const logger = store => next => action => {
    let result
    console.groupCollapsed("dispatching", action.type)
    console.log('prev state', store.getState())
    console.log('action', action)
    result = next(action)
    console.log('next state', store.getState())
    console.groupEnd()
}

const saver = store => next => action => {
    let result = next(action)
    localStorage['redux-store'] = JSON.stringify(store.getState())
    return result
}

const storeFactory = (stateData=initialState) =>
    applyMiddleware(logger, saver)(createStore)(
        combineReducers({ colors, sort }),
        (localStorage['redux-store']) ?
            JSON.parse(localStorage['redux-store']) :
            stateData
    )

export default storeFactory
