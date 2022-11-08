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
    <section class="modal-card-body" ref="newOffice">
     
      <div class="box" >

        <div class="columns is-centered">
          <div class="column is-centered">




            <div class="columns">
              <div class="column">
                <b-field label="Nombre de dependencia" >
                  <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                  <b-input
                    v-model="aux_name_office"
                    placeholder="Ingrese el nombre de la dependencia o como se identifica"
                  ></b-input>
                  <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                </b-field>
              </div>
               <div class="column">
                <b-field label="Ubicación" >
                  <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                  <b-input
                    v-model="aux_location"
                    placeholder="Ingrese la ubicación de la dependencia (Edificio, en que piso se encuentra..)"
                  ></b-input>
                  <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                </b-field>
              </div>



            </div>
            <div class="columns">
                            <div class="column">
                <b-field label="N° Identificación" >
                  <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                  <b-input
                    v-model="aux_identification_number_office"
                    placeholder="Ingrese el numero de identificación de la dependencia"
                  ></b-input>
                  <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                </b-field>
              </div>
                            <div class="column">
                <b-field
                  label="Identificación administración campus"
                  
                >
                <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                  <b-input
                    v-model="aux_campus_identification"
                    placeholder="Ingrese el numero de identificación de la dependencia"
                  ></b-input>
                  <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                </b-field>
              </div>

             


            </div>


            <div class="columns">

              <div class="column">
                <b-field label="Horas semanales disponibles" >
                  <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                  <b-numberinput
                    min="1"
                    max="100"
                    v-model="aux_hours_available"
                    type="is-info"
                    placeholder="Ingrese la cantidad de horas semanales disponibles de la dependencia"
                  >
                  </b-numberinput>
                  <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                </b-field>
              </div>

              <div class="column">
                <b-field label="Metros cuadrados" >
                  <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                  <b-numberinput
                    min="1"
                    max="100"
                    v-model="aux_square_meter"
                    type="is-info"
                    placeholder="Ingrese cuantos metro cuadrados tiene la dependencia"
                  >
                  </b-numberinput>
                  <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                </b-field>
              </div>

              
            </div>
               <div class="columns">
   
              <div class="column">
               

                <b-field label="Unidad" >
                  <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                  <multiselect
                    v-model="aux_unit_id"
                    :options="units.map((type) => type.id)"
                    :custom-label="
                      (opt) => units.find((x) => x.id === opt).name_unit
                    "
                    placeholder="Seleccionar Unidad"
                     selectLabel=""
                    selectedLabel="Seleccionado"
                    deselectLabel="Presione para deseleccionar"
                    :allow-empty="true"
                    :disabled="aux_duty_manager_id !== null || aux_building_id !== null "
                    @input="
                      getdutymanagerbyunit(aux_unit_id);
                      getbuildingbyunit(aux_unit_id);
                    "
                  >
                  </multiselect>
                  <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                </b-field>
              </div>

            </div>
            <div class="columns">
                            <div class="column">
                <b-field label="Edificio" >
                  <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                  <multiselect
                    v-model="aux_building_id"
                    :options="buildings.map((type) => type.id)"
                    :custom-label="
                      (opt) => buildings.find((x) => x.id === opt).name_building
                    "
                    placeholder="Seleccionar Unidad"
                    selectedLabel="Seleccionado"
                    deselectLabel="Presione para deseleccionar"
                    :allow-empty="true"
                    :disabled="aux_unit_id == null"
                  >
                    
                  </multiselect>
                  <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                </b-field>
              </div>
              <div class="column">
                <b-field label="Persona encargada" >
                  <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                  <multiselect
                    v-model="aux_duty_manager_id"
                    :options="managers.map((type) => type.id)"
                    :custom-label="
                      (opt) =>
                        managers.find((x) => x.id === opt).name_duty_manager
                    "
                    placeholder="Seleccionar Persona encargada"
                    selectLabel="Presione para seleccionar"
                    selectedLabel="Seleccionado"
                    deselectLabel="Presione para deseleccionar"
                    :allow-empty="true"
                    :disabled="aux_unit_id == null"
                  >
                  </multiselect>
                  <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                </b-field>
              </div>
            </div>
                        <div class="columns">

              <div class="column">
                <b-field label="Descripción de dependencia" >
                  <ValidationProvider name="nombre" rules="required" v-slot="{ errors }">
                  <b-input
                    v-model="aux_office_description"
                    type="textarea"
                    placeholder="Ingrese la descripción de la dependencia, indicando cual es su uso"
                  ></b-input>
                  <span class="validation-alert">{{ errors[0] }}</span>
                  </ValidationProvider>
                </b-field>
              </div>


                        </div>


            <b-field grouped position="is-right" >
              <p class="control">
                <b-button
                  label="Agregar dependencia"
                  type="is-info"
                  @click="check()"
                />
              </p>
            </b-field>
          </div>
        </div>
        </div>
    </section></div>
  </form>
 </ValidationObserver>
  </section>
</template>

<script>
import axios from "axios";
export default {
  name:"new_office",
  props:[
    'queryType', 'modalHeader'
  ],
  data() {
    return {
      selected: null,
      units: [],
      buildings: [],
      managers: [],
      offices: [],
      aux_name_office: null,
      aux_identification_number_office: null,
      aux_location: null,
      aux_office_description: null,
      aux_hours_available: null,
      aux_square_meter: null,
      aux_campus_identification: null,
      aux_duty_manager_id: null,
      aux_building_id: null,
      aux_unit_id: null,
      aux_active: 1,
    };
  },
  methods: {
    async getunit() {
      const response = await axios.get("/units/showactiveunit.json");
      this.units = response.data;
    },

    async getdutymanagerbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/duty_managers/showdutymanagerunit/" +
          item +
          ".json"
      );
      this.managers = response.data;
    },

    async getbuildingbyunit(item) {
      const response = await axios.get(
        "http://localhost:3000/buildings/showbuildingunit/" + item + ".json"
      );
      this.buildings = response.data;
    },

    async createClick() {
      const response = await axios.post("/offices.json", {
        name_office: this.aux_name_office,
        identification_number_office: this.aux_identification_number_office,
        location: this.aux_location,
        office_description: this.aux_office_description,
        hours_available: this.aux_hours_available,
        square_meter: this.aux_square_meter,
        campus_identification: this.aux_campus_identification,
        duty_manager_id: this.aux_duty_manager_id,
        building_id: this.aux_building_id,
        active_office: this.aux_active,
      });
      window.location.href = "/offices";
    },
    confirmregister() {
      this.$buefy.dialog.confirm({
        title: "Registrar Dependencia",
        message: `¿Esta seguro de registrar esta dependencia?`,
        cancelText: "Cancelar",
        confirmText: "Registrar",
        type: "is-info",
        onConfirm: () => this.createClick(),
      });
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
  },
};
</script>