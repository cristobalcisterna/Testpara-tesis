/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

// import Vue from 'vue'
// import App from '../app.vue'

// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     render: h => h(App)
//   }).$mount()
//   document.body.appendChild(app.$el)

//   console.log(app)
// })

import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import Buefy from 'buefy'
import 'buefy/dist/buefy.css'
import '../stylesheets/estilos'
import { library } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import VuePaginateAl from 'vue-paginate-al'
import setupCSRF from "./setupCSRF";
import { ValidationProvider,ValidationObserver, extend } from 'vee-validate';

import Multiselect from 'vue-multiselect'

library.add(fas)
Vue.component('vue-paginate-al', VuePaginateAl);
Vue.component('vue-fontawesome', FontAwesomeIcon);
Vue.component('ValidationProvider', ValidationProvider);
Vue.component('ValidationObserver', ValidationObserver);
Vue.component('multiselect', Multiselect)
Vue.use(Buefy, { defaultIconComponent: "vue-fontawesome",defaultIconPack: 'fas' })
Vue.use(TurbolinksAdapter)

// Componentes
import welcome from '../components/welcome.vue'
import PageSidebar from '../components/PageSidebar'
import ShowDutyManager from '../components/duty_manager/show_duty_manager.vue'
import IndexDutyManager from '../components/duty_manager/index_duty_manager.vue'
import IndexBuilding from '../components/building/index_building.vue'
import IndexOffice from '../components/office/index_office.vue'
import IndexGood from '../components/good/index_good.vue'
import ShowBuilding from '../components/building/show_building.vue'
import ShowOffice from '../components/office/show_office.vue'
import EditOffice from '../components/office/edit_office.vue'
import ShowGood from '../components/good/show_good.vue'
import NewGood from '../components/good/new_good.vue'
import NewDutyManager from '../components/duty_manager/new_duty_manager.vue'
import EditDutyManager from '../components/duty_manager/edit_duty_manager.vue'
import NewBuilding from '../components/building/new_building.vue'
import EditBuilding from '../components/building/edit_building.vue'
import NewOffice from '../components/office/new_office.vue'
import EditGood from '../components/good/edit_good.vue'
import IndexUnit from '../components/unit/index_unit.vue'
import ShowUnit from '../components/unit/show_unit.vue'
import NewUnit from '../components/unit/new_unit.vue'
import EditUnit from '../components/unit/edit_unit.vue'
import EditConditionGood from '../components/condition_good/edit_condition_good.vue'
import IndexConditionGood from '../components/condition_good/index_condition_good.vue'
import ShowConditionGood from '../components/condition_good/show_condition_good.vue'
import NewConditionGood from '../components/condition_good/new_condition_good.vue'

import IndexInvestmentTypes from '../components/investment_types/index_investment_types.vue'
import ShowInvestmentTypes from '../components/investment_types/show_investment_types.vue'
import NewInvestmentTypes from '../components/investment_types/new_investment_types.vue'

import IndexFinancialSources from '../components/financial_sources/index_financial_sources.vue'
import ShowFinancialSources from '../components/financial_sources/show_financial_sources.vue'
import NewFinancialSources from '../components/financial_sources/new_financial_sources.vue'

import IndexUser from '../components/user/index_user.vue'
import NewUser from '../components/user/new_user.vue'

import MyGoods from '../components/duty_manager/MyGoods.vue'
import MyOffices from '../components/duty_manager/MyOffices.vue'
import MyBuildings from '../components/duty_manager/MyBuildings.vue'
import ShowMyGood from '../components/good/show_my_good.vue'
import ShowMyOffice from '../components/office/show_my_office.vue'
import ShowMyBuilding from '../components/building/show_my_building.vue'


import { required, email,min_value, max_value,integer,numeric, min, max, regex, alpha_num, length, alpha_dash, between} from 'vee-validate/dist/rules'; 

extend('required', {
  ...required,
  message: 'Este campo es requerido'
});

extend('email', {
  ...email,
  message: 'No es un email válido'
});

document.addEventListener('turbolinks:load', () => {
  setupCSRF();
  const app = new Vue({
    el: '#app',
    data: () => {
      return {
        message: "Can you say hello?"
      }
    },
    components: { App,welcome, FontAwesomeIcon, PageSidebar, 
    IndexInvestmentTypes, ShowInvestmentTypes, NewInvestmentTypes, 
    IndexFinancialSources, ShowFinancialSources, NewFinancialSources, ShowDutyManager, 
    IndexUnit, ShowUnit, NewUnit, IndexDutyManager, IndexBuilding, IndexOffice, IndexGood, 
    ShowBuilding , ShowOffice , ShowGood, NewGood, NewDutyManager, NewBuilding, NewOffice, 
    EditGood, EditConditionGood, IndexConditionGood, ShowConditionGood, NewConditionGood, 
    EditUnit, EditBuilding, EditOffice, EditDutyManager, MyGoods, MyOffices, MyBuildings,
    ShowMyGood, ShowMyOffice, ShowMyBuilding, IndexUser, NewUser}
  })
})


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the project is using turbolinks, install 'vue-turbolinks':
//
// yarn add vue-turbolinks
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: () => {
//       return {
//         message: "Can you say hello?"
//       }
//     },
//     components: { App }
//   })
// })
