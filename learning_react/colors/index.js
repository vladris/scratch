import React from 'react'
import { render } from 'react-dom'
import AddColorForm from './components/ColorForm'

window.React = React

const logColor = (title, color) =>
    console.log(`New color: ${title} | ${color}`)

render(
    <AddColorForm onNewColor={logColor} />,
    document.getElementById("react-container")
)
