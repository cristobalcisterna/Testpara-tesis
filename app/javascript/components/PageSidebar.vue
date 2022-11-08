<template>
  <div>
    <section>
      <b-sidebar
          type="is-light"
          :fullheight=true
          v-model="open"
          id="sidebar-menu"

      >
        <div class="p-1">

          <img style="height:8rem" src="/logo_negro.png">

          <b-menu>
            <b-menu-list label="Menu">
              <multiselect v-if="cargosActivos!=null && cargosActivos.length>1 && cargoActivoSeleccionado!=null"
                           v-model="cargoActivoSeleccionado"
                           :options="cargosActivos.map(type => type.id)"
                           :custom-label="opt => cargosActivos.find(x => x.id === opt).name"
                           @input="changeActiveProfile"
                           placeholder="Seleccione cargo"
                           selectLabel="Presione para seleccionar"
                           selectedLabel="Seleccionado"
                           class="is-info" 
                           type="is-info"
                           deselectLabel="Seleccionado"
                           :allow-empty="false">
                <template v-slot:noOptions>
                  No existen datos
                </template>
              </multiselect>
              <div v-if= "cargoActivoSeleccionado">
              <b-menu-item    href="/" icon="home" label="Inicio"></b-menu-item>
                <b-menu-item  v-show='!(cargoActivoSeleccionado == 3)' href="/goods"  label="Bienes" icon="cube"></b-menu-item>
                <b-menu-item  v-show='!(cargoActivoSeleccionado == 3)' href="/duty_managers"  label="Personas asociadas" icon="id-card"></b-menu-item>
                <b-menu-item  v-show='!(cargoActivoSeleccionado == 3)' href="/offices"  label="Dependencias" icon="people-roof"></b-menu-item>
                <b-menu-item  v-show='!(cargoActivoSeleccionado == 3)' href="/buildings"  label="Edificios" icon="building"></b-menu-item>
                <b-menu-item  v-show='!(cargoActivoSeleccionado == 3)' href="/units"  label="Unidades" icon="people-group"></b-menu-item>
                <b-menu-item  v-show='!(cargoActivoSeleccionado == 3)' href="/financial_sources"  label="Fuentes financieras" icon="handshake"></b-menu-item>
                <b-menu-item  v-show='!(cargoActivoSeleccionado == 3)' href="/investment_types"  label="Tipos de inversiones" icon="hand-holding-dollar"></b-menu-item>
                <b-menu-item  v-show='!(cargoActivoSeleccionado == 3)' href="/condition_goods"  label="Bienes dados de baja" icon="people-carry-box"></b-menu-item>
                <b-menu-item icon="user" label="Mi cuenta" >
                  <b-menu-item  href="/duty_managers/mygoods"  label="Mis Bienes" icon="cube"></b-menu-item>
                  <b-menu-item  href="/duty_managers/myoffices"  label="Mis Dependencias" icon="people-roof"></b-menu-item>
                  <b-menu-item  href="/duty_managers/mybuildings"  label="Mis Edificios" icon="building"></b-menu-item>
                            </b-menu-item>
                
                          </div>
            </b-menu-list>
             
          </b-menu>
        </div>
        <footer class="footer" id="sidebar-footer">
          <b-menu-list label="Ayuda">
              <b-menu-item  @click="showModal =  true"
                            icon="address-book" label="Contacto"></b-menu-item>
          </b-menu-list>
        </footer>
      </b-sidebar>

      <b-button class="is primary is-small" @click="open = true" icon-left="bars"></b-button>
      <b-loading :is-full-page="true" v-model="isLoading" :can-cancel="false"></b-loading>
      <b-modal
          v-model="showModal"
          has-modal-card
          trap-focus
          :destroy-on-hide="true"
          aria-role="dialog"
          aria-modal>
        <template #default="props">
          <contact-modal
              @close="props.close"
             ></contact-modal>
        </template>
      </b-modal>
    </section>
  </div>
</template>
<script>
import axios from "axios";
import ContactModal from "./ContactModal.vue";
export default {
  components:{
    ContactModal,
  },
  data(){
    return{
      open: false,
      isLoading: false,
      cargoActivoSeleccionado:null,
      showModal: false,
      showseccion: true,
    }
  },
  created(){
    this.isLoading=true;
    this.cargoActivoSeleccionado = this.cargoActivo
    this.isLoading=false;
    console.log(this.cargoActivo);

    
  },
  props:[
      'userId','permisos','cargosActivos','cargoActivo',
  ],
  methods:{
    isAuthorized(nombre){
      var objeto = this.permisos.find(obj => obj.nombre === nombre)
      if (objeto!==undefined){
        return objeto.value;
      }
      else{
        return false
      }

    },

    changeActiveProfile(){
      let vm = this;
      vm.isLoading=true;
      axios
        .post("/users/"+vm.userId+"/change-profile", {
          active_profile: vm.cargoActivoSeleccionado
        })
        .then(response => {
          window.location.reload(false);
          vm.isLoading=false;
        }).
        catch(error => {
          var elmnt = document.getElementById("app");
          elmnt.scrollIntoView();
          vm.isLoading=false;
        })
    }

  },
  computed:{

  }
}
</script>

