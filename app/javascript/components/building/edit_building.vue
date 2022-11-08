<template>
    <section>
        <div class="modal-card" style="width: 62em; height: auto">
            <header class="modal-card-head">
                <p class="modal-card-title">{{ modalHeader }}</p>
                <button type="button" class="delete" @click="$emit('close')" />
            </header>
            <section class="modal-card-body" ref="editBuilding">
                <b-tabs>
                    <div class="box">
                        <div v-if="building" class="columns is-centered">
                            <div class="column is-centered">



                                <b-tabs type="is-boxed" position="is-centered">

                                    <b-tab-item label="Datos">
                                        <ValidationObserver v-slot="{ handleSubmit }" ref="observer">
                                            <form @submit.prevent="handleSubmit(checkEditData())">

                                        <div class="center">
                                            <h1>Datos del Bien</h1>
                                        </div>

                                        <div class="columns">
                                            <div class="column">
                                                <b-field label="Nombre">
                                                    <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                    <b-input v-model="building.name_building"
                                                        placeholder="Ingrese el nombre del edificio"></b-input>
                                                        <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                </b-field>
                                            </div>



                                        </div>
                                        <div class="columns">
                                            <div class="column">
                                                <b-field label="Numero edificio">
                                                    <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                    <b-input v-model="building.identification_number_building"
                                                        placeholder="Ingrese el numero de identificación edificio">
                                                    </b-input>
                                                    <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                </b-field>
                                            </div>
                                        </div>


                                        <div class="columns">
                                            <div class="column">
                                                <b-field label="Ubicación">
                                                    <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                    <b-input v-model="building.location_building"
                                                        placeholder="Ingrese la ubicación del edificio" type="textarea">
                                                    </b-input>
                                                    <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                </b-field>
                                            </div>
                                        </div>

                                        <b-field grouped position="is-right">
                                            <p class="control">
                                                <b-button label="Guardar" type="is-info" @click="checkEditData()" />
                                            </p>
                                        </b-field>
                                    </form>
                                        </ValidationObserver>
                                    </b-tab-item>







                                    <b-tab-item label="Cargos">
                                        <ValidationObserver v-slot="{ handleSubmit }" ref="observer">
                                            <form @submit.prevent="handleSubmit(confirmeditDes())">


                                        <div class="center">
                                            <h1>Designación del edificio</h1>
                                        </div>


                                        <div class="columns">
                                            <div class="column">
                                                <b-field label="Unidad">
                                                    <b-input v-model="building.unit.name_unit" type="text" readonly>
                                                    </b-input>
                                                </b-field>
                                            </div>




                                            <div class="column">
                                                <b-field label="Persona encargada">
                                                    <b-input v-model="building.duty_manager.name_duty_manager"
                                                        type="text" readonly></b-input>
                                                </b-field>
                                            </div>
                                        </div>



                                        <div>

                                            <div class="notification">
                                                <div class="content">
                                                    <h1 class="has-text-left">Nueva designación</h1>

                                                    <div class="columns">


                                                        <div class="column">
                                                            <b-field label="Nueva Unidad">
                                                                <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                                <multiselect v-model="aux_unit_id"
                                                                    :options="units.map((type) => type.id)"
                                                                    :custom-label="
                                                                        (opt) =>
                                                                            units.find((x) => x.id === opt).name_unit
                                                                    " placeholder="Seleccionar Unidad"
                                                                    selectedLabel="Seleccionado" selectLabel=""
                                                                    :allow-empty="true" :disabled="
                                                                        aux_duty_manager_id !== null
                                                                    " @input="getdutymanagerbyunit(aux_unit_id); ">
                                                                </multiselect>
                                                                <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                            </b-field>
                                                        </div>


                                                        <div class="column">
                                                            <b-field label="Nueva persona encargada">
                                                                <ValidationProvider name="Descripción" rules="required"
                                                                v-slot="{ errors }">
                                                                <multiselect v-model="aux_duty_manager_id"
                                                                    :options="managers.map((type) => type.id)"
                                                                    :custom-label="
                                                                        (opt) =>
                                                                            managers.find((x) => x.id === opt)
                                                                                .name_duty_manager
                                                                    " placeholder="Seleccionar persona encargada"
                                                                    selectLabel="Presione para seleccionar"
                                                                    selectedLabel="Seleccionado"
                                                                    deselectLabel="Presione para deseleccionar"
                                                                    :allow-empty="true" :disabled="aux_unit_id == null">
                                                                </multiselect>
                                                                <span class="validation-alert">{{ errors[0] }}</span>
                                                            </ValidationProvider>
                                                            </b-field>
                                                        </div>

                                                    </div>


                                                    <b-field grouped position="is-right">
                                                        <p class="control">
                                                            <b-button label="Guardar" type="is-info"
                                                                @click="checkCharge()" />
                                                        </p>
                                                    </b-field>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                        </ValidationObserver>
                                    </b-tab-item>
                                </b-tabs>
                            </div>
                        </div>
                        <div v-else>
                            <p>Loading</p>
                        </div>
                    </div>
                </b-tabs>
            </section>
        </div>
    </section>
</template>


<script>
import axios from "axios";
import IndexBuildings from "./index_building.vue";
import moment from "moment";
export default {
    name: "edit_building",
    props: ["queryType", "modalHeader", "buildingId", "id"],
    components: {
        "index-building": IndexBuildings,
    },

    data() {
        return {
            building: null,
            buildings: [],
            props: ["id"],
            units: [],
            managers: [],
            aux_unit_id: null,
            aux_duty_manager_id: null,
        };
    },
    methods: {
        async getbuilding() {
            const response = await axios.get("/buildings/" + this.id + ".json");
            this.loading = true;
            this.building = response.data;
        },

        async getunitactive() {
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

        async getofficebybuilding(item) {
            const response = await axios.get(
                "http://localhost:3000/offices/showofficebuilding/" + item + ".json"
            );
            this.offices = response.data;
        },


        //Funciones para editar datos del edificio
        async checkEditData(){
      const valid = await this.$refs.observer.validate() 
    if(!valid){ this.$buefy.dialog.alert(
      { message: 'Algunos campos presentan errores.', type: 'is-danger', 
    hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true }
    ) } 
    else{
      this.confirmedit();
    }
    },

        confirmedit() {
            this.$buefy.dialog.confirm({
                title: "Editar el edificio",
                message: `¿Esta seguro de editar el edificio?`,
                cancelText: "Cancelar",
                confirmText: "Guardar",
                type: "is-info",
                onConfirm: () => this.EditClick(),
            });
        },

        async EditClick() {
            const response = await axios.put("/buildings/" + this.id + ".json", {
                name_building: this.building.name_building,
                identification_number_building: this.building.identification_number_building,
                location_building: this.building.location_building,
            });
            window.location.href = "/buildings/" + this.id;
        },


        //Funciones para editar cargos del edificio

        async checkCharge(){
      const valid = await this.$refs.observer.validate() 
    if(!valid){ this.$buefy.dialog.alert(
      { message: 'Algunos campos presentan errores.', type: 'is-danger', 
    hasIcon: true, icon: 'times-circle', iconPack: 'fa', ariaRole: 'alertdialog', ariaModal: true }
    ) } 
    else{
      this.confirmeditDes();
    }
    },

        confirmeditDes() {
            this.$buefy.dialog.confirm({
                title: "Editar el edificio",
                message: `¿Esta seguro de editar el edificio?`,
                cancelText: "Cancelar",
                confirmText: "Guardar",
                type: "is-info",
                onConfirm: () => this.getofficebybuilding(),
            });
        },

        async getofficebybuilding() {
            const response = await axios.get(
                "/offices/showofficebuilding/" + this.id + ".json"
            );
            this.offices_building = response.data;
            //
            //if (this.offices_building.length == 0) {
            //    console.log(this.aux_unit_id);
            //    console.log(this.aux_duty_manager_id);
                this.EditClickDes();
            //}
            
            //else {
            //    this.$buefy.dialog.alert({
            //        title: 'No se puede cambiar designación',
            //        type: 'is-danger',
            //        message: 'Existen dependencias designados en el edificio',
            //        confirmText: 'Aceptar'
            //    })
            //}

        },
        async EditClickDes() {
            const response = await axios.put("/buildings/" + this.id + ".json", {
                duty_manager_id: this.aux_duty_manager_id,
                unit_id: this.aux_unit_id,
                activegood: 1,
            });
            console.log(this.aux_unit_id);
            window.location.href = "/buildings";
        },
        

    },
    created() {
        this.getbuilding();
        this.getunitactive();
    },
};
</script>




