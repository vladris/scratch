import Color from './Color'

const ColorList = ({ colors=[], onRate=f=>f, onRemove=f=>f }) =>
    <div className="color-list">
        {(colors.length === 0) ?
            <p>No colors listed. Add a color.</p> :
            colors.map(color =>
                <Color Key={color.id}
                       {...color} 
                       onRate={(rating) => onRate(color.id, rating)}
                       onRemove={() => onRemove(color.id)}
                />
            )
        }
    </div>

module.exports = ColorList
