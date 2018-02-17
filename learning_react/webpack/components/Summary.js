/*
createClass:

import createReactClass from 'create-react-class'
import PropTypes from 'prop-types'

const Summary = createReactClass({
    displayName: "Summary",
    propTypes: {
        ingredients: PropTypes.number.isRequired,
        steps: PropTypes.number.isRequired,
        title: (props, propName) =>
            (typeof props[propName] !== 'string') ?
                new Error("Title must be string") :
                (props[propName].length > 20) ?
                    new Error("Title too long") :
                    null
    },
    getDefaultProps() {
        return {
            ingredients: 0,
            steps: 0,
            title: "[recipe]"
        }
    },
    render() {
        const {ingredients, steps, title} = this.props
        return (
            <div className="summary">
                <h1>{title}</h1>
                <p>
                    <span>{ingredients} Ingredients</span> |
                    <span>{steps} Steps</span>
                </p>
            </div>
        )
    }
})
*/

/*
ES6 class:

import React from 'react'
import PropTypes from 'prop-types'

class Summary extends React.Component {
    render() {
        const {ingredients, steps, title} = this.props
        return (
            <div className="summary">
                <h1>{title}</h1>
                <p>
                    <span>{ingredients} Ingredients</span> |
                    <span>{steps} Steps</span>
                </p>
            </div>
        )
    }
}

Summary.propTypes = {
    ingredients: PropTypes.number,
    steps: PropTypes.number,
    title: (props, propName) => 
        (typeof props[propName] !== 'string') ?
            new Error("Title must be string") :
            (props[propName].length > 20) ?
                new Error("Title too long") :
                null
}

Summary.defaultProps = {
    ingredients: 0,
    steps: 0,
    title: "[recipe]"
}
*/

import PropTypes from 'prop-types'

const Summary = ({ ingredients=0, steps=0, title='[recipe]' }) => {
    return (
        <div>
            <h1>{title}</h1>
            <p>
                <span>{ingredients} Ingredients</span> |
                <span>{steps} Steps</span>
            </p>
        </div>
    )
}

Summary.propTypes = {
    ingredients: PropTypes.number,
    steps: PropTypes.number,
    title: (props, propName) => 
        (typeof props[propName] !== 'string') ?
            new Error("Title must be string") :
            (props[propName].length > 20) ?
                new Error("Title too long") :
                null
}

module.exports = Summary
