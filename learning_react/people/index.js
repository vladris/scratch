import * as React from 'react'
import { render } from 'react-dom'

const DataComponent = (ComposedComponent, url) => 
    class DataComponent extends React.Component {
        constructor(props) {
            super(props)
            this.state = {
                count: props.count,
                data: [],
                loading: false,
                loaded: false
            }
        }

        componentWillMount() {
            this.setState({loading:true})
            fetch(url + `?results=${this.state.count}`)
                .then(response => response.json())
                .then(data => this.setState({
                    loaded: true,
                    loading: false,
                    data
                }))
        }

        render() {
            return (
                <div className="data-component">
                    {(this.state.loading) ?
                       <div>Loading...</div> :
                       <ComposedComponent {...this.state} />}
                </div>
            )
        }
    }

const PeopleList = ({data}) =>
    <ol className="people-list">
        {data.results.map((person, i) => {
            const {first, last} = person.name
            return <li key={i}>{first} {last}</li>
        })}
    </ol>

const RandomMeUsers = DataComponent(
                          PeopleList,
                          "https://randomuser.me/api/"
                      )

render(
    <RandomMeUsers count={10} />,
    document.getElementById('react-container')
)
