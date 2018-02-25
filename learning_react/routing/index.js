import React from 'react'
import { render } from 'react-dom'
import { HashRouter, Link, Route, Switch } from 'react-router-dom'

export const Home = () =>
    <section className="home">
        <h1>[Home Page]</h1>
        <nav>
            <Link to="about">[About]</Link>
            <Link to="events">[Events]</Link>
            <Link to="products">[Products]</Link>
            <Link to="contact">[Contact Us]</Link>
        </nav>
    </section>

export const About = () =>
    <section className="events">
        <h1>[About the Company]</h1>
    </section>

export const Events = () =>
    <section className="events">
        <h1>[Events Calendar]</h1>
    </section>

export const Products = () =>
    <section className="products">
        <h1>[Products Catalog]</h1>
    </section>

export const Contact = () =>
    <section className="contact">
        <h1>[Contact Us]</h1>
    </section>

export const Whoops404 = ({ location }) =>
    <div className="whoops-404">
        <h1>Resource not found at '{location.pathname}'</h1>
    </div>

window.React = React

render(
    <HashRouter>
        <div className="main">
            <Switch>
                <Route exact path="/" component={Home} />
                <Route path="/about" component={About} />
                <Route path="/events" component={Events} />
                <Route path="/products" component={Products} />
                <Route path="/contact" component={Contact} />
                <Route component={Whoops404} />
            </Switch>
        </div>
    </HashRouter>,
    document.getElementById("react-container")
)
