<template>
    <section>
   
      <ValidationObserver v-slot="{ handleSubmit }" ref="observer" >
        <form @submit.prevent="handleSubmit(confirmregister())" >
   <div class="modal-card" style="width: 45em; height: auto">
      <header class="modal-card-head">
        <p class="modal-card-title">{{modalHeader}}</p>
        <button
            type="button"
            class="delete"
            @click="$emit('close')"/>
      </header>
      <section class="modal-card-body" ref="newUser">
        <div class="box" >
          <b-tabs>
          <div class="columns is-centered">
            <div class="column is-centered ">
  
              
            
  
              <div class="columns">
                <div class="column">
                  <b-field label="Nombre de Usuario" >
                    <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                    <b-input
                      v-model="aux_full_name"
                      placeholder="Ingrese nombre de usuario">
                      </b-input>
                      <span class="validation-alert">{{ errors[0] }}</span>
                    </ValidationProvider>
                  </b-field>
                </div>
              </div>
  
  
              
              <div class="columns">
                <div class="column">
                  <b-field label="rut" >
                    <ValidationProvider name="rut" rules="required" v-slot="{ errors }">
                    <b-input
                      v-model="aux_rut"
                      placeholder="Ingrese Rut del usuario"
                    ></b-input>
                    <span class="validation-alert">{{ errors[0] }}</span>
                    </ValidationProvider>
                  </b-field>
                </div>
                </div>
                <div class="columns">
                <div class="column">
                  <b-field label="Email" >
                    <ValidationProvider name="Email" rules="required" v-slot="{ errors }">
                    <b-input
                      v-model="aux_email"
                      placeholder="Ingrese correo del usuario"
                    ></b-input>
                    <span class="validation-alert">{{ errors[0] }}</span>
                    </ValidationProvider>
                  </b-field>
                </div>
              </div>


            <div class="columns">
                <div class="column">
                    <b-field label="Rol" >
                    <ValidationProvider name="Rol" rules="required" v-slot="{ errors }">
                    <multiselect
                    v-model="aux_rol"
                    :options="cargos.map((type) => type.id)"
                    :custom-label="(opt) => cargos.find((x) => x.id === opt).name"
                    placeholder="Seleccionar Rol"
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

  
  
  
              <b-field grouped position="is-right" >
                <p class="control">
                  <b-button
                    label="Agregar Usuario"
                    type="is-info"
                    @click="check()"
                  />
                </p>
              </b-field>
  
            
            </div>
          </div></b-tabs> </div
      >
      </section>
   </div>
  </form>
   </ValidationObserver>
    </section>
  </template>
  
  <script>
  import axios from "axios";
  export default {
    
    name:"new_user",
    props:[
      'queryType', 'modalHeader'
    ],
    data() {
      return {
        selected: null,
        users: [],
        cargos: [],
        aux_full_name: null,
        aux_rut: null,
        aux_email: null,
        aux_rol: null,

      };
    },
    methods: {
      async createClick() {
        console.log(this.aux_full_name);
        console.log(this.aux_email);
        console.log(this.aux_rut);
        console.log(this.aux_rol);
        const response = await axios.post("/users/newuser.json", {
            full_name: this.aux_full_name,
            rut: this.aux_rut,
            email: this.aux_email,
            internal_position_id: this.aux_rol,

       
        });
        
      },

      async getcargos() {
        const response = await axios.get("/internal_positions.json");
        this.cargos = response.data;
        console.log(this.cargos);
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
  
      confirmregister() {
        this.$buefy.dialog.confirm({
          title: "Registrar Usuario",
          message: `¿Esta seguro de registrar esta usuario?`,
          cancelText: "Cancelar",
          confirmText: "Registrar",
          type: "is-info",
  
          onConfirm: () => this.createClick(),
        });
      },
    },
    created() {
      this.getcargos();

    },

  };
  </script>