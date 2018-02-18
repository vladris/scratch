import Star from './Star'

/*
 createClass:

const StarRating = createClass({
    displayName: 'StarRating',
    propTypes: {
        totalStarts: PropTypes.number
    },
    getDefaultProps() {
        return {
            totalStars: 5
        }
    },
    getInitialState() {
        return {
            starsSelected: 0
        }
    },
    change(starsSelected) {
        this.setState({starsSelected})
    },
    render() {
        const {totalStars} = this.props
        const {starsSelected} = this.state
        return (
            <div className="star-rating">
                {[...Array(totalStars)].map((n, i) =>
                    <Star key={i}
                          selected={i < starsSelected}
                          onClick={() => this.change(i+1)}
                    />
                )}
                <p>{starsSelected} of {totalStars} stars</p>
            </div>
        )
    }
})
*/

/*
 ES6 Component:

class StarRating extends Component {
    constructor(props) {
        super(props)
        this.state {
            starsSelected: props.starsSelected || 0
        }
        this.change = this.change.bind(this)
    }


    change(starsSelected) {
        this.setState({starsSelected})
    }

    render() {
        const {totalStars} = this.props
        const {starsSelected} = this.state
        return (
            <div className="star-rating">
                {[...Array(totalStars)].map((n, i) =>
                    <Star key={i}
                          selected={i < starsSelected}
                          onClick={() => this.change(i+1)}
                    />
                )}
                <p>{starsSelected} of {totalStars} stars</p>
            </div>
}

StarRating.propTypes = {
    totalStars: PropTypes.number
}

StarRating.defaultProps = {
    totalStars: 5
}
*/

// Stateless (not state moves from component):
const StarRating = ({starsSelected=0, totalStars=5, onRate=f=>f}) =>
    <div className="star-rating">
        {[...Array(totalStars)].map((n, i) =>
            <Star key={i}
                  selected={i < starsSelected}
                  onClick={() => onRate(i+1)}
            />
        )}
        <p>{starsSelected} of {totalStars} stars</p>
    </div>

module.exports = StarRating
