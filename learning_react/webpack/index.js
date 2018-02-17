import React from 'react'
import { render } from 'react-dom'
import Menu from './components/Menu'
import Summary from './components/Summary'
import data from './data/recipes'

window.React = React

render(
    <Summary />,
    document.getElementById("react-container")
)
