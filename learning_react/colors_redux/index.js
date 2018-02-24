import storeFactory from './store'
import { addColor } from './creators'

const store = storeFactory()

store.dispatch(addColor('#FFFFFF', 'Bright White'))
store.dispatch(addColor('#00FF00', 'Lawn'))
store.dispatch(addColor('#0000FF', 'Big Blue'))
