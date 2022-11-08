<template>
  <section>
    <ValidationObserver v-slot="{ handleSubmit }" ref="observer" >
      <form @submit.prevent="handleSubmit(confirmregister())" >
      <div class="modal-card" style="width: 62em; height: auto">
    <header class="modal-card-head">
      <p class="modal-card-title">{{modalHeader}}</p>
      <button
          type="button"
          class="delete"
          @click="$emit('close')"/>
    </header>
    <section class="modal-card-body" ref="newDutyManager">
    
       <div class="box"> 
          <b-tabs> 
         <div class="columns is-centered">
        <div class="column is-centered">


      <div class="columns">
      <div class="column">
    <b-field label="Unidad" >
      <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
      <multiselect
      v-model="aux_unit_id"
      :options="units.map((type) => type.id)"
      :custom-label="(opt) => units.find((x) => x.id === opt).name_unit"
      placeholder="Seleccionar Unidad"
       selectLabel=""
      selectedLabel="Seleccionado"
      deselectLabel="" 
      :allow-empty="false"
      >
      </multiselect>
      <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
    </b-field>
      </div>
 </div>






 <div class="columns">
      <div class="column">
    <b-field label="Usuario" >
      <ValidationProvider name="Nombre" rules="required" v-slot="{ errors }">
      <multiselect
      v-model="aux_user_id"
      :options="users.map((type) => type.id)"
      :custom-label="(opt) => users.find((x) => x.id === opt).full_name"
      placeholder="Seleccionar usuario"
       selectLabel=""
      selectedLabel="Seleccionado"
      deselectLabel=""
      :allow-empty="false"
      @input="getuser(aux_user_id);"
      >
      </multiselect>
      <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
    </b-field>
      </div>
 </div>






 
    <b-field grouped position="is-right" >
      <p class="control">
        <b-button label="Agregar Persona asociada" type="is-info" @click="check()" />
      </p>
    </b-field>
        </div></div>
         </b-tabs>
       </div>
    
    </section>
      </div>
    </form>
 </ValidationObserver>
  </section>
</template>

<script>
import axios from "axios";
export default {
    name:"new_duty_manager",
  props:[
    'queryType', 'modalHeader'
  ],
  data() {
    return {
      selected: null,
      managers: [],
      units: [],
      users: [],
      aux_name: null,
      aux_rut: null,
      aux_email: null,
      aux_unit_id: null,
      aux_user_id: null,
      aux_active: 1,
      userData: null,
    };
  },
  methods: {
    async getunit() {
      const response = await axios.get("/units/showactiveunit.json");
      this.units = response.data;

    },


    async getusers() {
      const response = await axios.get("/users.json");
     this.users = response.data;
     console.log(this.users);
    },



    async getuser(item) {
      const response = await axios.get( "/users/" +item +".json");
      this.userData = response.data;
      this.aux_name = this.userData.full_name;
     this.aux_rut = this.userData.rut;
     this.aux_email = this.userData.email;
    },
    
    async createClick() {
      const response = await axios.post("/duty_managers.json", {
        unit_id: this.aux_unit_id,
        user_id: this.aux_user_id,
        active_duty_manager: this.aux_active,
        name_duty_manager:this.aux_name,
        rut:this.aux_rut,
        email:this.aux_email,
      });
      console.log(this.aux_unit_id);
      window.location.href = "/duty_managers";
    },
    confirmregister() {
                this.$buefy.dialog.confirm({
                    title: 'Registra Persona asociada',
                    message: `¿Esta seguro de registrar a la persona asociada?`,
                    cancelText: 'Cancelar',
                    confirmText: 'Registrar',
                    type: 'is-info',
                    onConfirm: () => this.createClick()
                })
            },
    async check(){
      const valid = await this.$refs.observer.validate() 
    if(!valid){ this.$buefy.dialog.alert(
      { message: 'Algunos campos presentan errores.', type: 'is-danger', 
    hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true }
    ) } 
    else{
      this.confirmregister();
    }
    },
  },
  created() {
    this.getunit();
    this.getusers();
  },
};
</script>