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
    <section class="modal-card-body" ref="newUnit">
      <div class="box" >
        <b-tabs>
        <div class="columns is-centered">
          <div class="column is-centered ">

            
          

            <div class="columns">
              <div class="column">
                <b-field label="Nombre de Unidad" >
                  <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                  <b-input
                    v-model="aux_name_unit"
                    placeholder="Ingrese el nombre de la unidad">
                    </b-input>
                    <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                </b-field>
              </div>
            </div>


            
            <div class="columns">
              <div class="column">
                <b-field label="Descripción" >
                  <ValidationProvider name="Descripción" rules="required" v-slot="{ errors }">
                  <b-input
                    v-model="aux_description_unit"
                    placeholder="Ingrese la descripción de la unidad"
                  ></b-input>
                  <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                </b-field>
              </div>
              </div>
              <div class="columns">
              <div class="column">
                <b-field label="N° Identificación" >
                  <ValidationProvider name="Identificación" rules="required" v-slot="{ errors }">
                  <b-input
                    v-model="aux_identification_number_unit"
                    placeholder="Ingrese el numero de identificación de la unidad"
                  ></b-input>
                  <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                </b-field>
              </div>
            </div>



            <b-field grouped position="is-right" >
              <p class="control">
                <b-button
                  label="Agregar Unidad"
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
  
  name:"new_unit",
  props:[
    'queryType', 'modalHeader'
  ],
  data() {
    return {
      selected: null,
      units: [],
      aux_name_unit: null,
      aux_description_unit: null,
      aux_identification_number_unit: null,
      aux_active: 1,
    };
  },
  methods: {
    async createClick() {
      const response = await axios.post("/units.json", {
        name_unit: this.aux_name_unit,
        description_unit: this.aux_description_unit,
        identification_number_unit: this.aux_identification_number_unit,
        active_unit: this.aux_active,
      });
      window.location.href = "/units";
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
        title: "Registrar Unidad",
        message: `¿Esta seguro de registrar esta unidad?`,
        cancelText: "Cancelar",
        confirmText: "Registrar",
        type: "is-info",

        onConfirm: () => this.createClick(),
      });
    },
  },
};
</script>